import 'package:cnblog/components/appbar_gradient.dart';
import 'package:cnblog/pages/questions/tab_questions_page.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/components/SearchInput.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage>
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
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_questions_nosolved)), //待解决
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_questions_highscore)), //高分
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_questions_noanswer)), //没有答案
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_questions_solved)), //已解决
            Tab(text: IntlUtil.getString(context,LanguageKey.tab_questions_myquestion)) //我的问题
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TabQuestionsPage(labId: LanguageKey.tab_questions_nosolved),
          TabQuestionsPage(labId: LanguageKey.tab_questions_highscore),
          TabQuestionsPage(labId:LanguageKey.tab_questions_noanswer),
          TabQuestionsPage(labId:LanguageKey.tab_questions_solved),
          TabQuestionsPage(labId:LanguageKey.tab_questions_myquestion)
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
