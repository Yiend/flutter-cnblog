import 'dart:async';
import 'dart:convert';

import 'package:cnblog/components/appbar_gradient.dart';
import 'package:cnblog/resources/styles.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/resources/colors.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef void PageFinishCallback(WebViewController controller);

class WebViewScaffold extends StatefulWidget {
  const WebViewScaffold(
      {Key key,
      this.title,
      this.labId,
      this.url,
      this.onPageFinished,
      this.javascriptChannels})
      : super(key: key);

  final String title;
  final String labId;
  final String url;
  final PageFinishCallback onPageFinished;
  final Set<JavascriptChannel> javascriptChannels;

  _WebViewScaffoldState createState() => _WebViewScaffoldState();
}

class _WebViewScaffoldState extends State<WebViewScaffold> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Future<String> loadHtml() async {
    return await rootBundle.loadString(widget.url);
  }

  Widget _buildWebView() {
    return FutureBuilder<String>(
        future: loadHtml(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl: new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName("UTF-8"))
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: widget.javascriptChannels,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) async {
                var controller = await _controller.future;
                widget.onPageFinished(controller);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // return CircularProgressIndicator();
        });
  }

  void _onPopSelected(String value) {
    switch (value) {
      case "browser":
        NavigatorUtil.launchInBrowser(widget.url,
            title: widget.title ?? IntlUtil.getString(context, widget.labId));
        break;
      case "collection":
        break;

      case "share":
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: new Text(
            widget.title ?? IntlUtil.getString(context, widget.labId),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        gradientStart: Color(0xFF3865F7), 
        gradientEnd: Colors.deepPurple[300],
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    // PopupMenuItem<String>(
                    //     value: "browser",
                    //     child: ListTile(
                    //         contentPadding: EdgeInsets.all(0.0),
                    //         dense: false,
                    //         title: new Container(
                    //           alignment: Alignment.center,
                    //           child: new Row(
                    //             children: <Widget>[
                    //               Icon(
                    //                 Icons.language,
                    //                 color: AppColors.gray_66,
                    //                 size: 22.0,
                    //               ),
                    //               Gaps.hGap10,
                    //               Text(
                    //                 '浏览器打开',
                    //                 style: TextStyles.listContent,
                    //               )
                    //             ],
                    //           ),
                    //         ))),
                    PopupMenuItem<String>(
                        value: "share",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: AppColors.gray_66,
                                    size: 22.0,
                                  ),
                                  Gaps.hGap10,
                                  Text(
                                    '分享',
                                    style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
                  ])
        ],
      ),
      body: _buildWebView(),
     // floatingActionButton: FloatingButton(widget.title,widget.titleId,this._controller.future),
    );
  }
}

// class FloatingButton extends StatelessWidget {
//   const FloatingButton(this.title,this.titleId,this._webViewControllerFuture)
//       : assert(_webViewControllerFuture != null);

//   final String title;
//   final String titleId;
//   final Future<WebViewController> _webViewControllerFuture;


//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<WebViewController>(
//         future: _webViewControllerFuture,
//         builder:
//             (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
//           final WebViewController _controller = snapshot.data;
//           if (_controller == null || _controller.scrollY < 480) {
//             return null;
//           }
//           return new FloatingActionButton(
//               heroTag: this.title ?? this.titleId,
//               backgroundColor: Theme.of(context).primaryColor,
//               child: Icon(
//                 Icons.keyboard_arrow_up,
//               ),
//               onPressed: () {
//                 _controller.scrollTop();
//               });
//         });
//   }
// }
