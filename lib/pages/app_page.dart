import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/home_bloc.dart';
import 'package:cnblog/blocs/news_bloc.dart';
import 'package:cnblog/blocs/statuses_bloc.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/resources/strings.dart';

//page
import 'package:cnblog/pages/home/home_page.dart';
import 'package:cnblog/pages/news/news_page.dart';
import 'package:cnblog/pages/statuses/statuses_page.dart';

class NavigationIconView {
  final String _title;
  final Widget _icon;
  final Widget _activeIcon;
  //final BottomNavigationBarItem navigationBarItem;

  NavigationIconView({Key key, String title, Widget icon, Widget activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon;
  // navigationBarItem = new BottomNavigationBarItem(
  //   icon: icon,
  //   activeIcon: activeIcon,
  //   title: Text(title),
  //   backgroundColor: Colors.white,
  // );
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
      BlocProvider<HomeBloc>(
        bloc: HomeBloc(),
        child: HomePage(),
      ),
      BlocProvider<NewsBloc>(
        bloc: NewsBloc(),
        child: NewsPage(),
      ),
      BlocProvider<StatusesBloc>(
        bloc: StatusesBloc(),
        child: StatusesPage(),
      ),
      Container(color: Colors.white),
      Container(color: Colors.grey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationIconViews.map((NavigationIconView navigationIconView) {
        return BottomNavigationBarItem(
          icon: navigationIconView._icon,
          activeIcon: navigationIconView._activeIcon,
          title: Text(IntlUtil.getString(context, navigationIconView._title)),
          backgroundColor: Colors.white,
        );
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _selectNavigation,
    );

    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[_currentIndex];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {},
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
}
