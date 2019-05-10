import 'dart:collection';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/news_model.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/services/news_service.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

class NewsBloc implements BlocBase {
  final NewsService newsService = new NewsService();

  //最新新闻集合
  BehaviorSubject<List<NewsModel>> _latestNews =
      BehaviorSubject<List<NewsModel>>();
  Sink<List<NewsModel>> get _latestNewsSink => _latestNews.sink;
  Stream<List<NewsModel>> get latestNewsStream => _latestNews.stream;
  int _latestNewsPageIndex = 1;
  List<NewsModel> _latestNewsList;

  //推荐新闻集合
  BehaviorSubject<List<NewsModel>> _recommendNews =
      BehaviorSubject<List<NewsModel>>();
  Sink<List<NewsModel>> get _recommendNewsSink => _recommendNews.sink;
  Stream<List<NewsModel>> get recommendNewsStream => _recommendNews.stream;
  int _recommendNewsPageIndex = 1;
  List<NewsModel> _recommendNewsList;

  //本周热门新闻集合
  BehaviorSubject<List<NewsModel>> _weekNews =
      BehaviorSubject<List<NewsModel>>();
  Sink<List<NewsModel>> get _weekNewsSink => _weekNews.sink;
  Stream<List<NewsModel>> get weekNewsStream => _weekNews.stream;
  int _weekNewsPageIndex = 1;
  List<NewsModel> _weekNewsList;

  //新闻内容
  BehaviorSubject<String> _newsContent = BehaviorSubject<String>();
  Sink<String> get _newsContentSink => _newsContent.sink;
  Stream<String> get newsContentStream => _newsContent.stream;

  //新闻评论
  BehaviorSubject<List<Map>> _newsComments = BehaviorSubject<List<Map>>();
  Sink<List<Map>> get _newsCommentsSink => _newsComments.sink;
  Stream<List<Map>> get newsCommentsStream => _newsComments.stream;
  List<Map> _newscomments;

  @override
  BehaviorSubject<StatusEvent> event = new BehaviorSubject<StatusEvent>();

  @override
  Sink<StatusEvent> get eventSink => event.sink;

  @override
  Stream<StatusEvent> get eventStream => event.stream.asBroadcastStream();

  @override
  void dispose() {
    event.close();
    _latestNews.close();
    _recommendNews.close();
    _weekNews.close();
    _newsContent.close();
    _newsComments.close();
  }

  @override
  Future getData(RefreshType type, {String labId, int page}) {
    switch (labId) {
      case LanguageKey.tab_news_latestNews:
        _geLatestNews(labId, type, page);
        break;
      case LanguageKey.tab_news_recommendedNews:
        _getRecommendNewsNews(labId, type, page);
        break;
      case LanguageKey.tab_news_weekNews:
        _getWeekNewsNews(labId, type, page);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labId}) {
    int _page = 1;
    switch (labId) {
      case LanguageKey.tab_news_latestNews:
        _page = ++_latestNewsPageIndex;
        break;
      case LanguageKey.tab_news_recommendedNews:
        _page = ++_recommendNewsPageIndex;
        break;
      case LanguageKey.tab_news_weekNews:
        _page = ++_weekNewsPageIndex;
        break;
      default:
        break;
    }
    return getData(RefreshType.load, labId: labId, page: _page);
  }

  @override
  Future onRefresh({String labId}) {
    switch (labId) {
      case LanguageKey.tab_news_latestNews:
        _latestNewsPageIndex = 1;
        break;
      case LanguageKey.tab_news_recommendedNews:
        _recommendNewsPageIndex = 1;
        break;
      case LanguageKey.tab_news_weekNews:
        _weekNewsPageIndex = 1;
        break;
      default:
        break;
    }
    return getData(RefreshType.refresh, labId: labId, page: 1);
  }

  Future _geLatestNews(String labId, RefreshType type, int page) async {
    try {
      var latestNews = await newsService.getLatestNews(pageIndex: page);
      if (_latestNewsList == null) {
        _latestNewsList = new List();
      }
      if (page == 1) {
        _latestNewsList.clear();
      }
      _latestNewsList.addAll(latestNews);
      _latestNewsSink.add(UnmodifiableListView<NewsModel>(_latestNewsList));

      _sendEvent(type: type, labId: labId, obj: latestNews);
    } catch (e) {
      _latestNewsPageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future _getRecommendNewsNews(String labId, RefreshType type, int page) async {
    try {
      var recommendNews = await newsService.getRecommendNews(pageIndex: page);
      if (_recommendNewsList == null) {
        _recommendNewsList = new List();
      }
      if (page == 1) {
        _recommendNewsList.clear();
      }
      _recommendNewsList.addAll(recommendNews);
      _recommendNewsSink
          .add(UnmodifiableListView<NewsModel>(_recommendNewsList));

      _sendEvent(type: type, labId: labId, obj: recommendNews);
    } catch (e) {
      _recommendNewsPageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future _getWeekNewsNews(String labId, RefreshType type, int page) async {
    try {
      var weekNews = await newsService.getWeekNews(pageIndex: page);

      if (_weekNewsList == null) {
        _weekNewsList = new List();
      }
      if (page == 1) {
        _weekNewsList.clear();
      }
      _weekNewsList.addAll(weekNews);
      _weekNewsSink.add(UnmodifiableListView<NewsModel>(_weekNewsList));

      _sendEvent(type: type, labId: labId, obj: weekNews);
    } catch (e) {
      _weekNewsPageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future getNewsContent(int newId) async {
    var content = await newsService.getNewsContent(newId);
    _newsContentSink.add(content);
  }

 Future getNewsComments(int newsId, int pageIndex, int pageSize) async {
    var comments = await newsService.getNewsComments(newsId,pageIndex,pageSize);
    if (_newscomments == null) {
      _newscomments = new List();
    }
     if (pageIndex == 1) {
        _newscomments.clear();
      }
    _newscomments.addAll(comments);
    _newsCommentsSink.add(UnmodifiableListView<Map>(_newscomments));
  }


  Future _sendEvent(
      {String labId, RefreshType type, Object obj, bool isErr = false}) {
    if (isErr) {
      switch (type) {
        case RefreshType.refresh:
          eventSink
              .add(new StatusEvent(labId, type, RefreshStatus.failed.index));
          break;
        case RefreshType.load:
          eventSink.add(new StatusEvent(labId, type, LoadStatus.noMore.index));
          break;
        default:
      }
    } else {
      switch (type) {
        case RefreshType.refresh:
          eventSink.add(new StatusEvent(
              labId,
              type,
              ObjectUtil.isEmpty(obj)
                  ? RefreshStatus.failed.index
                  : RefreshStatus.completed.index));
          break;
        case RefreshType.load:
          eventSink.add(new StatusEvent(
              labId,
              type,
              ObjectUtil.isEmpty(obj)
                  ? LoadStatus.noMore.index
                  : LoadStatus.idle.index));
          break;
        default:
      }
    }
  }
}
