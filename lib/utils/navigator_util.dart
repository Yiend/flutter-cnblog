import 'package:cnblog/utils/object_util.dart';
import 'package:cnblog/widgets/webview_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigatorUtil {

  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null || ObjectUtil.isEmpty(pageName)) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushWebView(BuildContext context,
      {String title, String labId, String url, PageFinishCallback onPageFinished,Set<JavascriptChannel> javascriptChannels}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? labId);
    } else {
      Navigator.push(
          context,
             MaterialPageRoute<void>(
             builder: (ctx) => new WebViewScaffold(
                    title: title,
                    labId: labId,
                    url: url,
                    onPageFinished:onPageFinished ,
                    javascriptChannels: javascriptChannels,
                  )
           ),
          // CupertinoPageRoute<void>(
          //     builder: (ctx) => new WebViewScaffold(
          //           title: title,
          //           titleId: titleId,
          //           url: url,
          //           onPageFinished:onPageFinished ,
          //           javascriptChannels: javascriptChannels,
          //         ))
        );
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
