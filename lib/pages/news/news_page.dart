import 'package:flutter/material.dart';
import '../../components/SearchInput.dart';
import '../../common/const/strings.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>  with SingleTickerProviderStateMixin {
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
            Tab(text: Strings.latestNews),
            Tab(text: Strings.recommendedNews),
            Tab(text: Strings.weekNews),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(color: Colors.black),
          Container(color: Colors.white),
          Container(color: Colors.red),
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
