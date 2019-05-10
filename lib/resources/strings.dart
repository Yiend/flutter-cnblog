import 'package:flutter/material.dart';
import 'package:cnblog/resources/languages.dart';

class Strings {
  static const Map<String, Map<String, Map<String, String>>> localizedValues = {
    'en': {
      'US': {
        LanguageKey.languageZH: '简体中文',
        LanguageKey.languageEN: 'English',
        LanguageKey.appName: 'CnBlogs',
        //菜单
        LanguageKey.menu_home: 'Home',
        LanguageKey.menu_news: 'News',
        LanguageKey.menu_statuses: 'Statuses',
        LanguageKey.menu_questions: 'Questions',
        LanguageKey.menu_me: 'Me',
        //Tab blog
        LanguageKey.tab_home_blog: 'Blos',
        LanguageKey.tab_home_essence: 'Essence',
        LanguageKey.tab_home_knowledge: 'Knowledge',
        //news
        LanguageKey.tab_news_latestNews: 'Latest News',
        LanguageKey.tab_news_recommendedNews: 'Recommended News',
        LanguageKey.tab_news_weekNews: 'Week News',
        //Statuses
        LanguageKey.tab_statuses_all: 'All',
        LanguageKey.tab_statuses_follow: 'Follow',
        LanguageKey.tab_statuses_my: 'My',
        LanguageKey.tab_statuses_mycomment: 'My Comment',
        LanguageKey.tab_statuses_replyMe: 'Reply Me',

        LanguageKey.titleCollection: 'Collection',
        LanguageKey.titleSetting: 'Setting',
        LanguageKey.titleAbout: 'About',
        LanguageKey.titleShare: 'Share',
        LanguageKey.titleSignOut: 'Sign Out',
        LanguageKey.titleLanguage: 'Language',
        LanguageKey.save: 'Save',
        LanguageKey.more: 'More',
        LanguageKey.recRepos: 'Reco Repos',
        LanguageKey.recWxArticle: 'Reco WxArticle',
        LanguageKey.titleReposTree: 'Repos Tree',
        LanguageKey.titleWxArticleTree: 'Wx Article',
        LanguageKey.titleTheme: 'Theme',
      }
    },
    'zh': {
      'CN': {
        LanguageKey.languageZH: '简体中文',
        LanguageKey.languageEN: 'English',
        LanguageKey.appName: '博客园',
        //菜单
        LanguageKey.menu_home: '首页',
        LanguageKey.menu_news: '新闻',
        LanguageKey.menu_statuses: '闪存',
        LanguageKey.menu_questions: '博问',
        LanguageKey.menu_me: '我',
        //Tab blog
        LanguageKey.tab_home_blog: '博客',
        LanguageKey.tab_home_essence: '精华',
        LanguageKey.tab_home_knowledge: '知识库',
        //news
        LanguageKey.tab_news_latestNews: '最新新闻',
        LanguageKey.tab_news_recommendedNews: '推荐新闻',
        LanguageKey.tab_news_weekNews: '本周热门',
        //Statuses
        LanguageKey.tab_statuses_all: '全站',
        LanguageKey.tab_statuses_follow: '关注',
        LanguageKey.tab_statuses_my: '我的',
        LanguageKey.tab_statuses_mycomment: '我回应',
        LanguageKey.tab_statuses_replyMe: '回复我',

        LanguageKey.titleShare: '分享',
        LanguageKey.titleSignOut: '注销',
        LanguageKey.titleLanguage: '多语言',
        
        LanguageKey.save: '保存',
        LanguageKey.more: '更多',
        LanguageKey.recRepos: '推荐项目',
        LanguageKey.recWxArticle: '推荐公众号',
        LanguageKey.titleReposTree: '项目分类',
        LanguageKey.titleWxArticleTree: '公众号',
        LanguageKey.titleTheme: '主题',
      },
    }
  };

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
      'title': LanguageKey.menu_home,
      'icon': new Icon(Icons.home),
      'activeIcon': new Icon(Icons.home)
    },
    {
      'title': LanguageKey.menu_news,
      'icon': new Icon(Icons.list),
      'activeIcon': new Icon(Icons.filter_list)
    },
    {
      'title': LanguageKey.menu_statuses,
      'icon': new Icon(Icons.message),
      'activeIcon': new Icon(Icons.message)
    },
    {
      'title': LanguageKey.menu_questions,
      'icon': new Icon(Icons.help),
      'activeIcon': new Icon(Icons.help_outline)
    },
    {
      'title': LanguageKey.menu_me,
      'icon': new Icon(Icons.person),
      'activeIcon': new Icon(Icons.person_pin)
    }
  ];
}
