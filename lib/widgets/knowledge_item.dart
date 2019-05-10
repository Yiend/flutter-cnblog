import 'dart:convert';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/home_bloc.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/resources/colors.dart';
import 'package:cnblog/utils/date_util.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/model/article_model.dart';
import 'package:rxdart/rxdart.dart';

bool isKbInit = true;

class KnowledgeItem extends StatelessWidget {
  KnowledgeItem({Key key, this.article, this.labId}) : super(key: key);

  final String labId;
  final KbArticle article;

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

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of<HomeBloc>(context);
    bloc.blogContentStream.listen((onData) {
      article.body = onData;
    });

    if (isKbInit) {
      isKbInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.getKbArticleContent(article.id);
      });
    }

    return InkWell(
        onTap: () {
          NavigatorUtil.pushWebView(
            context,
            title: article.title,
            labId: labId,
            url: Constant.kbarticlesUrl,
            onPageFinished: (controller) {
              controller.evaluateJavascript(
                  "updateModel(" + json.encode(article.toJson()) + ");");
            },
          );
        },
        child: Card(
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
                    height: 2.0,
                  ),
                  Text(
                    this.article.author == null ? "" : this.article.author, //作者
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    this.article.summary == null
                        ? ""
                        : this.article.summary, //简介
                    overflow: TextOverflow.visible,
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
                            infoItem(Icons.play_arrow,
                                this.article.viewCount.toString(), "浏览"), //浏览数
                            infoItem(Icons.arrow_upward,
                                this.article.diggCount.toString(), "推荐"), //推荐
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          DateUtil.getDateStrByDateTime(this.article.dateAdded,
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
