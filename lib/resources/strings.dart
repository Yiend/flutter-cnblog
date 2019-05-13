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
        //Questions
        LanguageKey.tab_questions_nosolved: "No solved",
        LanguageKey.tab_questions_highscore: "High score",
        LanguageKey.tab_questions_noanswer: "No answer",
        LanguageKey.tab_questions_solved: "Solved",
        LanguageKey.tab_questions_myquestion: "My question",

        LanguageKey.page_setting: 'Setting',
        LanguageKey.page_about: 'About',
        LanguageKey.page_language: 'Language',
        LanguageKey.save: 'Save',
        LanguageKey.more: 'More',
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
        //Questions
        LanguageKey.tab_questions_nosolved: "待解决",
        LanguageKey.tab_questions_highscore: "高分",
        LanguageKey.tab_questions_noanswer: "没有答案",
        LanguageKey.tab_questions_solved: "已解决",
        LanguageKey.tab_questions_myquestion: "我的问题",

        LanguageKey.page_setting: '设置',
        LanguageKey.page_about: '关于',
        LanguageKey.page_language: '多语言',
        LanguageKey.save: '保存',
        LanguageKey.more: '更多',
      },
    }
  };

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
