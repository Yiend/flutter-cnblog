import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/model/questions_model.dart';
import 'package:cnblog/utils/date_util.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:cnblog/widgets/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionsItem extends StatelessWidget {
  QuestionsItem({Key key, this.labId, this.question}) : super(key: key);

  final Questions question;
  final String labId;
  int _pageIndex = 1;
  int _pageSize = 20;
  WebViewController _controller;

  Widget infoItem(IconData icon, String info, String title) {
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
          title,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        )
      ],
    );
  }

  // Future<void> _updateComments(List<Map> _comments) async {
  //   if (_comments.length > 0) {
  //     _pageIndex++;
  //     if (_comments.length < _pageSize) {
  //       _controller.evaluateJavascript(
  //           "updateLoadStatus(${LoadMoreStatus.stausEnd.index});");
  //     } else {
  //       _controller.evaluateJavascript(
  //           "updateLoadStatus(${LoadMoreStatus.stausDefault.index});");
  //     }
  //   } else {
  //     var status = _pageIndex > 1
  //         ? LoadMoreStatus.stausEnd.index
  //         : LoadMoreStatus.stausNodata.index;
  //     _controller.evaluateJavascript("updateLoadStatus(${status});");
  //   }

  //   _controller
  //       .evaluateJavascript("updateComments(" + json.encode(_comments) + ");");
  // }

  // JavascriptChannel _updateCommentsJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'flutterReload',
  //       onMessageReceived: (JavascriptMessage message) {
  //         final StatusesBloc statusesBloc =
  //             BlocProvider.of<StatusesBloc>(context);
  //         statusesBloc.getStatusesComments(question.id);
  //         statusesBloc.statusesCommentsStream.listen((onData) {
  //           _updateComments(onData);
  //         });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () {
          NavigatorUtil.pushWebView(
            context,
            title: question.contentDisplay,
            labId: labId,
            url: Constant.statuseUrl,
            onPageFinished: (controller) {
              _controller = controller;
              controller.evaluateJavascript(
                  "updateModel(" + json.encode(question.toJson()) + ");");
            },
            // javascriptChannels: <JavascriptChannel>[
            //   _updateCommentsJavascriptChannel(context),
            // ].toSet(),
          );
        },
        child: new Card(
            elevation: 10.0, //设置阴影
            // shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(
            //       topLeft: Radius.circular(20.0),
            //       topRight: Radius.zero,
            //       bottomLeft: Radius.zero,
            //       bottomRight: Radius.circular(20.0)),
            // ),  //设置圆角
            //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
            //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
            clipBehavior: Clip.antiAlias,
            semanticContainer: false,
            child: Container(
              width: 200,
              margin: EdgeInsets.only(
                  left: 15.0, top: 20.0, right: 15.0, bottom: 15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: 40,
                          height: 40,
                          imageUrl: question.questionUserInfo.iconDisplay,
                          placeholder: (context, url) => CoolLoading(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ), //头像
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        this.question.questionUserInfo.userName, //作者
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                  Text(
                    question.title, //标题
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
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
                                  Icons.comment,
                                  this.question.answerCount.toString(),
                                  "回答"), //回答数,
                              infoItem(
                                  Icons.chat_bubble_outline,
                                  this.question.viewCount.toString(),
                                  "阅读"), //阅读数 ,
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(
                          DateUtil.getDateStrByDateTime(
                              this.question.dateAdded,
                              format: DateFormat.YEAR_MONTH_DAY), //时间
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
