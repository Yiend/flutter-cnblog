import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/home_bloc.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/model/article_model.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/resources/colors.dart';
import 'package:cnblog/utils/date_util.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:cnblog/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool isBlogInit = true;

class BlogItem extends StatelessWidget {
  BlogItem({Key key, this.labId, this.article}) : super(key: key);

  final ArticleModel article;
  final String labId;
  int _pageIndex = 1;
  int _pageSize = 20;
  WebViewController _controller;

  Widget infoItem(IconData icon, String info, String tip) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 18.0,
          color: Colors.grey,
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          info,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        Text(
          tip,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        )
      ],
    );
  }

  Future<void> _updateComments(List<Map> _comments) async {
    if (_comments.length > 0) {
      _pageIndex++;
      if (_comments.length < _pageSize) {
        _controller.evaluateJavascript(
            "updateLoadStatus(${LoadMoreStatus.stausEnd.index});");
      } else {
        _controller.evaluateJavascript(
            "updateLoadStatus(${LoadMoreStatus.stausDefault.index});");
      }
    } else {
      var status = _pageIndex > 1
          ? LoadMoreStatus.stausEnd.index
          : LoadMoreStatus.stausNodata.index;
      _controller.evaluateJavascript("updateLoadStatus(${status});");
    }

    _controller
        .evaluateJavascript("updateComments(" + json.encode(_comments) + ");");
  }

  JavascriptChannel _updateCommentsJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'flutterReload',
        onMessageReceived: (JavascriptMessage message) {
          final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
          bloc.getArticleComments(
              article.blogApp, article.id, _pageIndex, _pageSize);
        });
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    bloc.blogContentStream.listen((onData) {
      article.body = onData;
    });

    bloc.blogCommentsStream.listen((onData) {
      _updateComments(onData);
    });

    if (isBlogInit) {
      isBlogInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.getArticleContent(article.id);
      });
    }

    return new InkWell(
        onTap: () {
          NavigatorUtil.pushWebView(
            context,
            title: article.title,
            labId: labId,
            url: Constant.articleUrl,
            onPageFinished: (controller) {
              _controller = controller;
              controller.evaluateJavascript(
                  "updateModel(" + json.encode(article.toJson()) + ");");
            },
            javascriptChannels: <JavascriptChannel>[
              _updateCommentsJavascriptChannel(context),
            ].toSet(),
          );
        },
        child: new Card(
          elevation: 10.0, //设置阴影
          child: Container(
              padding: EdgeInsets.all(10.0),
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title, //标题
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //CircleAvatar
                      ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: 40,
                          height: 40,
                          imageUrl: article.avatar,
                          placeholder: (context, url) => CoolLoading(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ), //头像
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        this.article.author, //作者
                        style: TextStyle(fontSize: 15.0),
                      ),
                      // SizedBox(
                      //    width: 10.0,
                      // ),
                    ],
                  ),
                  Text(
                    this.article.description, //简介
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              infoItem(
                                  Icons.play_arrow,
                                  this.article.viewCount.toString(),
                                  "浏览"), //浏览数,
                              infoItem(
                                  Icons.chat_bubble_outline,
                                  this.article.commentCount.toString(),
                                  "评论"), //评论数 ,
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          DateUtil.getDateStrByDateTime(this.article.postDate,
                              format: DateFormat.YEAR_MONTH_DAY), //时间
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border(
                      bottom: new BorderSide(
                          width: 0.33, color: AppColors.divider)))),
        ));
  }
}
