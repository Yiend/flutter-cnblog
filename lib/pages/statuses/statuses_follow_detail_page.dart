import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cnblog/services/statuses_service.dart';
import 'package:cnblog/model/statuses_model.dart';
import 'package:cnblog/model/enums.dart';

class StatusesFollowDetailPage extends StatefulWidget {
  String title;
  StatusesModel statusesModel;
  StatusesFollowDetailPage(
      {Key key, @required this.statusesModel, @required this.title})
      : super(key: key);

  _StatusesFollowDetailPageState createState() =>
      _StatusesFollowDetailPageState();
}

class _StatusesFollowDetailPageState extends State<StatusesFollowDetailPage> {
  bool isLoad = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  Future<String> loadHtml() async {
    return await rootBundle.loadString('assets/statuses.html');
  }

  Future<void> _updateComments() async {
    var comments =
        await new StatusesService().getComments(widget.statusesModel.id);
    var controller = await _controller.future;
    var jsonStr = json.encode(comments);
    
    if (comments != null) {
      controller.evaluateJavascript(
          "updateLoadStatus(${LoadMoreStatus.stausEnd.index});");
    } else {
      controller.evaluateJavascript(
          "updateLoadStatus(${LoadMoreStatus.stausNodata.index});");
    }

    controller.evaluateJavascript("updateComments(" + jsonStr + ");");
  }

  JavascriptChannel _updateCommentsJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'flutterReload',
        onMessageReceived: (JavascriptMessage message) {
          _updateComments();
        });
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
              javascriptChannels: <JavascriptChannel>[
                _updateCommentsJavascriptChannel(context),
              ].toSet(),
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) async {
                var controller = await _controller.future;
                controller.evaluateJavascript("updateModel(" +
                    json.encode(widget.statusesModel.toJson()) +
                    ");");
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
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
