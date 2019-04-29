import 'package:flutter/material.dart';

class Strings {
  static const String appName = "博客园";
  static const String blog = "博客";
  static const String essence = "精华";
  static const String knowledge = "知识库";
  static const String latestNews = "最新新闻";
  static const String recommendedNews = "推荐新闻";
  static const String weekNews = "本周热门";

  //菜单
  static final List menuData = [
    {
      'title': '首页',
      'icon': new Icon(Icons.home),
      'activeIcon': new Icon(Icons.home)
    },
    {
      'title': '新闻',
      'icon': new Icon(Icons.list),
      'activeIcon': new Icon(Icons.filter_list)
    },
    {
      'title': '闪存',
      'icon': new Icon(Icons.message),
      'activeIcon': new Icon(Icons.message)
    },
    {
      'title': '博问',
      'icon': new Icon(Icons.help),
      'activeIcon': new Icon(Icons.help_outline)
    },
    {
      'title': '我',
      'icon': new Icon(Icons.person),
      'activeIcon': new Icon(Icons.person_pin)
    }
  ];
}
