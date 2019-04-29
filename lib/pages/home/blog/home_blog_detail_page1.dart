import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../../model/article_model.dart';
import '../../../services/blog_service.dart';
import '../../../utils/timeline_util.dart';

class HomeBlogDetailPage1 extends StatefulWidget {
  String title;
  ArticleModel articleModel;
  HomeBlogDetailPage1({Key key, @required this.articleModel,@required this.title}) : super(key: key);

  _HomeBlogDetailPage1State createState() => _HomeBlogDetailPage1State();
}

class _HomeBlogDetailPage1State extends State<HomeBlogDetailPage1> {
  bool isLoad = true;

  var flutterWebViewPlugin = new FlutterWebviewPlugin();

  void _getBolgContent() async {
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
    return await rootBundle.loadString('assets/articles.html');
  }

  Widget _buildWebviewScaffold() {
    return FutureBuilder<String>(
        future: loadHtml(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebviewScaffold(
              url: new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName("UTF-8"))
                  .toString(),
              appBar: AppBar(
                title: new Text(widget.title,textAlign: TextAlign.center),
                bottom: new PreferredSize(
                    preferredSize: const Size.fromHeight(1.0),
                    child: isLoad
                        ? new LinearProgressIndicator()
                        : new Divider(
                            height: 1.0,
                            color: Theme.of(context).primaryColor,
                          )),
              ),
              withZoom: true, // 允许网页缩放
              withLocalStorage: true, // 允许LocalStorage
              withJavascript: true, // 允许执行js代码
            );
          }
          return CircularProgressIndicator();
        });
  }

  @override
  void initState() {
    super.initState();
    _getBolgContent();

    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        String script =
            'window.addEventListener("message", receiveMessage, false);' +
                'function receiveMessage(event) {FlutterJsInterface.methodName(event.data);}';
        flutterWebViewPlugin.evalJavascript(script);

        var jsonStr = json.encode(widget.articleModel.toJson());
        flutterWebViewPlugin.evalJavascript("updateModel(" + jsonStr + ");");

        // 加载完成
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWebviewScaffold();
  }
}
