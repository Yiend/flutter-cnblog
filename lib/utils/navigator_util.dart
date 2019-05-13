import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/questions_bloc.dart';
import 'package:cnblog/pages/questions/tab_questions_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_follow_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_my_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_mycomment_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_replyme_page.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:cnblog/widgets/webview_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cnblog/blocs/statuses_bloc.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null || ObjectUtil.isEmpty(pageName)) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushLoginCallBack(BuildContext context, {String labId}) {
    if (context == null || labId == null) return;
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      switch (labId) {
        case LanguageKey.tab_statuses_follow:
          return BlocProvider<StatusesBloc>(
              bloc: StatusesBloc(), child: StatusesFollowPage(labId: labId));
        case LanguageKey.tab_statuses_my:
         return BlocProvider<StatusesBloc>(
              bloc: StatusesBloc(), child: StatusesMyPage(labId: labId));
        case LanguageKey.tab_statuses_mycomment:
         return BlocProvider<StatusesBloc>(
              bloc: StatusesBloc(), child: StatusesMyCommentPage(labId: labId));
        case LanguageKey.tab_statuses_replyMe:
        return BlocProvider<StatusesBloc>(
              bloc: StatusesBloc(), child: StatusesReplyMePage(labId: labId));
        case LanguageKey.tab_questions_nosolved:
        case LanguageKey.tab_questions_highscore:
        case LanguageKey.tab_questions_noanswer:
        case LanguageKey.tab_questions_solved:
        case LanguageKey.tab_questions_myquestion:
         return BlocProvider<QuestionsBloc>(
              bloc: QuestionsBloc(), child: TabQuestionsPage(labId: labId));

        default:
      }
    }), (route) => route == null);
  }

  static void pushWebView(BuildContext context,
      {String title,
      String labId,
      String url,
      PageFinishCallback onPageFinished,
      Set<JavascriptChannel> javascriptChannels}) {
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
                  onPageFinished: onPageFinished,
                  javascriptChannels: javascriptChannels,
                )),
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
