import 'package:cnblog/components/appbar_gradient.dart';
import 'package:cnblog/pages/statuses/tab_statuses_all_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_follow_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_my_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_mycomment_page.dart';
import 'package:cnblog/pages/statuses/tab_statuses_replyme_page.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/components/SearchInput.dart';

class StatusesPage extends StatefulWidget {
  @override
  _StatusesPageState createState() => _StatusesPageState();
}

class _StatusesPageState extends State<StatusesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
 

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 5);

  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: buildSearchInput(context),
        elevation: 0.0,
        gradientStart: Color(0xFF3865F7), 
        gradientEnd: Colors.deepPurple[300],
        bottom: TabBar(
          controller: _tabController,
          // indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_statuses_all)), //全站
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_statuses_follow)), //关注
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_statuses_my)), //我的
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_statuses_mycomment)), //我回应
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_statuses_replyMe)) //回复我
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          StatusesAllPage(labId: LanguageKey.tab_statuses_all),
          StatusesFollowPage(labId: LanguageKey.tab_statuses_follow),
          StatusesMyPage(labId:LanguageKey.tab_statuses_my),
          StatusesMyCommentPage(labId:LanguageKey.tab_statuses_mycomment),
          StatusesReplyMePage(labId:LanguageKey.tab_statuses_replyMe)
        ],
      ),
    );
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        return null;
        // List<WidgetPoint> list = await widgetControl.search(value);

        // return list
        //     .map((item) => new MaterialSearchResult<String>(
        //           value: item.name,
        //           icon: WidgetName2Icon.icons[item.name] ?? null,
        //           text: 'widget',
        //           onTap: () {
        //             onWidgetTap(item, context);
        //           },
        //         ))
        //     .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
  }
}
