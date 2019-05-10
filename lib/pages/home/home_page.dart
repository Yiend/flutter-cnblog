import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/components/appbar_gradient.dart';
import 'package:cnblog/pages/home/tab_home_blog_page.dart';
import 'package:cnblog/pages/home/tab_home_picked_page.dart';
import 'package:cnblog/pages/home/tab_home_knowledge_page.dart';
import 'package:cnblog/components/SearchInput.dart';
import 'package:cnblog/resources/languages.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  TabController _tabController;
  
  @override
  void initState() {
    super.initState();
     _tabController = new TabController(vsync: this, initialIndex: 0, length: 3);
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
        elevation:0.0,
        gradientStart: Color(0xFF3865F7), 
        gradientEnd: Colors.deepPurple[300],
        bottom: TabBar(
            controller: _tabController,
          // indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(text: IntlUtil.getString(context,LanguageKey.tab_home_blog)),
              Tab(text: IntlUtil.getString(context,LanguageKey.tab_home_essence)),
              Tab(text: IntlUtil.getString(context,LanguageKey.tab_home_knowledge)),
            ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
           HomeBlogPage(labId: LanguageKey.tab_home_blog),
           HomePickedPage(labId:LanguageKey.tab_home_essence),
           HomeknowledgePage(labId: LanguageKey.tab_home_knowledge)
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


