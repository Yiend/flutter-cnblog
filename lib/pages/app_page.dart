import 'package:cnblog/pages/news/news_page.dart';
import 'package:flutter/material.dart';
import '../common/const/strings.dart';
//page
import './home/home_page.dart';
import './news/news_page.dart';
import './statuses/statuses_page.dart';

class NavigationIconView {
  final String _title;
  final Widget _icon;
  final Widget _activeIcon;
  final BottomNavigationBarItem navigationBarItem;

  NavigationIconView({Key key, String title, Widget icon, Widget activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        navigationBarItem = new BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: Colors.white,
        );
}

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  PageController _pageController;
  //当前选择页
  int _currentIndex = 0;
  //导航集合
  List<NavigationIconView> _navigationIconViews = [];
  //页面集合
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    //初始化添加底部导航
    for (var item in Strings.menuData) {
      _navigationIconViews.add(new NavigationIconView(
          title: item['title'],
          icon: item['icon'],
          activeIcon: item['activeIcon']));
    }

    //初始化导航页面
    _pageController = new PageController(initialPage: _currentIndex);

    _pages = [
      HomePage(),
      NewsPage(),
      StatusesPage(),
      Container(color: Colors.white),
      Container(color: Colors.grey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationIconViews
          .map((NavigationIconView navigationIconView) =>
              navigationIconView.navigationBarItem)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _selectNavigation,
    );

    return Scaffold(
      /*appBar: AppBar(
        elevation: 0.0, //设置阴影
        title: Text(Strings.AppName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressedBySearch,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onPressedByAdd,
          )
        ],
      ),*/
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[_currentIndex];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  void _selectNavigation(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  /*
   搜索图标点击事件
  */
  void onPressedBySearch() {
    print("点击搜索");
  }

  /*
   加号图标事件
  */
  void onPressedByAdd() {
    print("点击加号");
  }
}
