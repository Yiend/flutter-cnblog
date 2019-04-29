import 'package:flutter/material.dart';

import '../home/blog/home_blog_page.dart';
import '../home/picked/home_picked_page.dart';
import '../home/knowledge/home_knowledge_page.dart';
import '../../components/SearchInput.dart';
import '../../common/const/strings.dart';

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
      appBar: AppBar(
        title: buildSearchInput(context),
        elevation:0.0,
        bottom: TabBar(
          controller: _tabController,
         // indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(text: Strings.blog),
            Tab(text: Strings.essence),
            Tab(text: Strings.knowledge),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
           HomeBlogPage(),
           HomePickedPage(),
           HomeknowledgePage()
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
