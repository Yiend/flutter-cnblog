import 'package:flutter/material.dart';

class Strings {
  static const String appName = "博客园";
  //blog
  static const String blog = "博客";
  static const String essence = "精华";
  static const String knowledge = "知识库";
  //news
  static const String latestNews = "最新新闻";
  static const String recommendedNews = "推荐新闻";
  static const String weekNews = "本周热门";
  //Statuses
  static const String allStatuses = "全站";
  static const String follow = "关注";
  static const String my = "我的";
  static const String mycomment = "我回应";
  static const String replyMe = "回复我";

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
