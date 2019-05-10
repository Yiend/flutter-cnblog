import 'dart:collection';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/model/article_model.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/services/blog_service.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BlocBase {
  final BlogService blogService = new BlogService();

  //文章集合
  BehaviorSubject<List<ArticleModel>> _article =
      BehaviorSubject<List<ArticleModel>>();
  Sink<List<ArticleModel>> get _articleBlogSink => _article.sink;
  Stream<List<ArticleModel>> get articleBlogStream => _article.stream;
  int _blogPageIndex = 1;
  List<ArticleModel> _blogList;

//精华文章列表
  BehaviorSubject<List<ArticleModel>> _picked =
      BehaviorSubject<List<ArticleModel>>();
  Sink<List<ArticleModel>> get _pickedSink => _picked.sink;
  Stream<List<ArticleModel>> get pickedStream => _picked.stream;
  int _pickedPageIndex = 1;
  List<ArticleModel> _pickedList;

//文章内容
  BehaviorSubject<String> _blogContent = BehaviorSubject<String>();
  Sink<String> get _blogContentSink => _blogContent.sink;
  Stream<String> get blogContentStream => _blogContent.stream;

//文章评论
  BehaviorSubject<List<Map>> _blogComments = BehaviorSubject<List<Map>>();
  Sink<List<Map>> get _blogCommentsSink => _blogComments.sink;
  Stream<List<Map>> get blogCommentsStream => _blogComments.stream;
  List<Map> _comments;

//知识库
  BehaviorSubject<List<KbArticle>> _kbArticle =
      BehaviorSubject<List<KbArticle>>();
  Sink<List<KbArticle>> get _kbArticleSink => _kbArticle.sink;
  Stream<List<KbArticle>> get kbArticleStream => _kbArticle.stream;
  int _kbArticlePageIndex = 1;
  List<KbArticle> _kbArticleList;

//文章内容
  BehaviorSubject<String> _kbArticleContent = BehaviorSubject<String>();
  Sink<String> get _kbArticleContentContentSink => _kbArticleContent.sink;
  Stream<String> get kbArticleContentContentStream => _kbArticleContent.stream;

  @override
  BehaviorSubject<StatusEvent> event = new BehaviorSubject<StatusEvent>();

  @override
  Sink<StatusEvent> get eventSink => event.sink;

  @override
  Stream<StatusEvent> get eventStream => event.stream.asBroadcastStream();

  @override
  void dispose() {
    _article.close();
    _blogContent.close();
    _blogComments.close();
    _picked.close();
    _comments.clear();

    _kbArticle.close();
    _kbArticleContent.close();

    event.close();
  }

  @override
  Future getData(RefreshType type, {String labId, int page}) {
    switch (labId) {
      case LanguageKey.tab_home_blog:
        _getBlogData(labId, type, page);
        break;
      case LanguageKey.tab_home_essence:
        _getPickedData(labId, type, page);
        break;
      case LanguageKey.tab_home_knowledge:
        _getKbArticleData(labId, type, page);
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
      case LanguageKey.tab_home_blog:
        _page = ++_blogPageIndex;
        break;
      case LanguageKey.tab_home_essence:
        _page = ++_pickedPageIndex;
        break;
      case LanguageKey.tab_home_knowledge:
        _page = ++_kbArticlePageIndex;
        break;
      default:
        break;
    }
    return getData(RefreshType.load, labId: labId, page: _page);
  }

  @override
  Future onRefresh({String labId}) {
    switch (labId) {
      case LanguageKey.tab_home_blog:
        _blogPageIndex = 1;
        break;
      case LanguageKey.tab_home_essence:
        _pickedPageIndex = 1;
        break;
      case LanguageKey.tab_home_knowledge:
        _kbArticlePageIndex = 1;
        break;
      default:
        break;
    }
    return getData(RefreshType.refresh, labId: labId, page: 1);
  }

  Future _getBlogData(String labId, RefreshType type, int page) async {
    try {
      var blogs = await blogService.getHomeArticles(pageIndex: page);
      if (_blogList == null) {
        _blogList = new List();
      }
      if (page == 1) {
        print("下拉刷新");
        _blogList.clear();
      }
      _blogList.addAll(blogs);
      _articleBlogSink.add(UnmodifiableListView<ArticleModel>(_blogList));
      print("下拉成功");
      _sendEvent(type: type, labId: labId, obj: blogs);
    } catch (e) {
      print("下拉刷新异常：$e");
      _blogPageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future _getPickedData(String labId, RefreshType type, int page) async {
    try {
      var picked = await blogService.getPickedArticles(pageIndex: page);
      if (_pickedList == null) {
        _pickedList = new List();
      }
      if (page == 1) {
        _pickedList.clear();
      }
      _pickedList.addAll(picked);
      _pickedSink.add(UnmodifiableListView<ArticleModel>(_pickedList));

      _sendEvent(type: type, labId: labId, obj: picked);
    } catch (e) {
      _blogPageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future getArticleContent(int blogId) async {
    var content = await blogService.getArticleContent(blogId);
    _blogContentSink.add(content);
  }

  Future getArticleComments(
      String blogApp, int postId, int pageIndex, int pageSize) async {
    var comments = await blogService.getArticleComments(
        blogApp, postId, pageIndex, pageSize);

    if (_comments == null) {
      _comments = new List();
    }
    if (pageIndex == 1) {
      _comments.clear();
    }
    _comments.addAll(comments);
    _blogCommentsSink.add(UnmodifiableListView<Map>(_comments));
  }

  Future _getKbArticleData(String labId, RefreshType type, int page) async {
    try {
      var kbArticle = await blogService.getKnowledgeArticles(pageIndex: page);
      if (_kbArticleList == null) {
        _kbArticleList = new List();
      }
      if (page == 1) {
        _kbArticleList.clear();
      }
      _kbArticleList.addAll(kbArticle);
      _kbArticleSink.add(UnmodifiableListView<KbArticle>(_kbArticleList));

      _sendEvent(type: type, labId: labId, obj: kbArticle);
    } catch (e) {
      _kbArticlePageIndex--;
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future getKbArticleContent(int blogId) async {
    var content = await blogService.getKbArticleContent(blogId);
    _kbArticleContentContentSink.add(content);
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
