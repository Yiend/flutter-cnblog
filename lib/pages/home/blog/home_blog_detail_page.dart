import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../../../model/article_model.dart';
import '../../../services/blog_service.dart';
import '../../../utils/timeline_util.dart';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class HomeBlogDetailPage extends StatefulWidget {
  ArticleModel articleModel;
  HomeBlogDetailPage({Key key, @required this.articleModel})
      : super(key: key);

  _HomeBlogDetailPageState createState() => _HomeBlogDetailPageState();
}

class _HomeBlogDetailPageState extends State<HomeBlogDetailPage> {
  bool isLoad = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Future<void> _getBolgContent() async {
    var content =
        await new BlogService().getArticleContent(widget.articleModel.id);
    setState(() {
      widget.articleModel.body = content;
      widget.articleModel.dateDisplay = TimelineUtil.formatByDateTime(
              widget.articleModel.postDate,
              locale: 'zh')
          .toString();
    });
  }

  Future<String> loadHtml() async {
  //  await _getBolgContent();
    return await rootBundle.loadString('assets/articles.html');
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
                  .toString(), // maybe you Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")).toString()
              javascriptMode: JavascriptMode.unrestricted,
              // javascriptChannels: <JavascriptChannel>[
              //   _toasterJavascriptChannel(context),
              // ].toSet(),
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                // await c.evaluateJavascript("updateModel(" +
                //        json.encode(widget.articleModel.toJson()) +
                //     ");");
              },
              onPageFinished: (String url) {
                print("页面加载完成");
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'flutterReload',
        onMessageReceived: (JavascriptMessage message) {
          _controller.future.then((c) async {
            var comments = await new BlogService().getArticleContent(1);
            await c.evaluateJavascript("updateComments(" + comments + ");");
          });
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("博文"),
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoad
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      body: _buildWebView(),
    );
  }
}
