import 'dart:collection';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/statuses_model.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/services/statuses_service.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

class StatusesBloc implements BlocBase {
  final StatusesService statusesService = new StatusesService();

  //all
  BehaviorSubject<List<StatusesModel>> _all =
      BehaviorSubject<List<StatusesModel>>();
  Sink<List<StatusesModel>> get _allSink => _all.sink;
  Stream<List<StatusesModel>> get allStream => _all.stream;
  int _allPageIndex = 1;
  List<StatusesModel> _allList;

  //following
  BehaviorSubject<List<StatusesModel>> _following =
      BehaviorSubject<List<StatusesModel>>();
  Sink<List<StatusesModel>> get _followingSink => _following.sink;
  Stream<List<StatusesModel>> get followingStream => _following.stream;
  int _followingPageIndex = 1;
  List<StatusesModel> _followingList;

  //my
  BehaviorSubject<List<StatusesModel>> _my =
      BehaviorSubject<List<StatusesModel>>();
  Sink<List<StatusesModel>> get _mySink => _my.sink;
  Stream<List<StatusesModel>> get myStream => _my.stream;
  int _myPageIndex = 1;
  List<StatusesModel> _myList;

  //mycomment
  BehaviorSubject<List<StatusesModel>> _mycomment =
      BehaviorSubject<List<StatusesModel>>();
  Sink<List<StatusesModel>> get _mycommentSink => _mycomment.sink;
  Stream<List<StatusesModel>> get mycommentStream => _mycomment.stream;
  int _mycommentPageIndex = 1;
  List<StatusesModel> _mycommentList;

  //replyme
  BehaviorSubject<List<StatusesModel>> _replyme =
      BehaviorSubject<List<StatusesModel>>();
  Sink<List<StatusesModel>> get _replymeSink => _replyme.sink;
  Stream<List<StatusesModel>> get replymeStream => _replyme.stream;
  int _replymePageIndex = 1;
  List<StatusesModel> _replymeList;

  //评论
  BehaviorSubject<List<Map>> _statusesComments = BehaviorSubject<List<Map>>();
  Sink<List<Map>> get _statusesCommentsSink => _statusesComments.sink;
  Stream<List<Map>> get statusesCommentsStream => _statusesComments.stream;
  List<Map> _statusescomments;

  @override
  BehaviorSubject<StatusEvent> event = new BehaviorSubject<StatusEvent>();

  @override
  Sink<StatusEvent> get eventSink => event.sink;

  @override
  Stream<StatusEvent> get eventStream => event.stream.asBroadcastStream();

  @override
  void dispose() {
    event.close();
    _all.close();
    _following.close();
    _statusesComments.close();
    _my.close();
    _mycomment.close();
    _replyme.close();
  }

  @override
  Future getData(RefreshType type, {String labId, int page}) {
    switch (labId) {
      case LanguageKey.tab_statuses_all:
        if (_allList == null) {
          _allList = new List();
        }
        if (page == 1) {
          _allList.clear();
        }
        _getData(StatusesType.all, labId, type, page);
        break;
      case LanguageKey.tab_statuses_follow:
        if (_followingList == null) {
          _followingList = new List();
        }
        if (page == 1) {
          _followingList.clear();
        }
        _getData(StatusesType.following, labId, type, page);
        break;
      case LanguageKey.tab_statuses_my:
        if (_myList == null) {
          _myList = new List();
        }
        if (page == 1) {
          _myList.clear();
        }
        _getData(StatusesType.my, labId, type, page);
        break;
      case LanguageKey.tab_statuses_mycomment:
        if (_mycommentList == null) {
          _mycommentList = new List();
        }
        if (page == 1) {
          _mycommentList.clear();
        }
        _getData(StatusesType.mycomment, labId, type, page);
        break;
      case LanguageKey.tab_statuses_replyMe:
        if (_replymeList == null) {
          _replymeList = new List();
        }
        if (page == 1) {
          _replymeList.clear();
        }
        _getData(StatusesType.recentcomment, labId, type, page);
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
      case LanguageKey.tab_statuses_all:
        _page = ++_allPageIndex;
        break;
      case LanguageKey.tab_statuses_follow:
        _page = ++_followingPageIndex;
        break;
      case LanguageKey.tab_statuses_my:
        _page = ++_myPageIndex;
        break;
      case LanguageKey.tab_statuses_mycomment:
        _page = ++_mycommentPageIndex;
        break;
      case LanguageKey.tab_statuses_replyMe:
        _page = ++_replymePageIndex;
        break;
      default:
        break;
    }
    return getData(RefreshType.load, labId: labId, page: _page);
  }

  @override
  Future onRefresh({String labId}) {
    switch (labId) {
      case LanguageKey.tab_statuses_all:
        _allPageIndex = 1;
        break;
      case LanguageKey.tab_statuses_follow:
        _followingPageIndex = 1;
        break;
      case LanguageKey.tab_statuses_my:
        _myPageIndex = 1;
        break;
      case LanguageKey.tab_statuses_mycomment:
        _mycommentPageIndex = 1;
        break;
      case LanguageKey.tab_statuses_replyMe:
        _replymePageIndex = 1;
        break;
      default:
        break;
    }
    return getData(RefreshType.refresh, labId: labId, page: 1);
  }

  Future _getData(StatusesType statusesType, String labId, RefreshType type,
      int page) async {
    var statuses =
        await statusesService.getStatuses(statusesType, pageIndex: page);
    try {
      switch (statusesType) {
        case StatusesType.all:
          _allList.addAll(statuses);
          _allSink.add(UnmodifiableListView<StatusesModel>(_allList));
          break;
        case StatusesType.following:
          _followingList.addAll(statuses);
          _followingSink
              .add(UnmodifiableListView<StatusesModel>(_followingList));
          break;
        case StatusesType.my:
          _myList.addAll(statuses);
          _mySink.add(UnmodifiableListView<StatusesModel>(_myList));
          break;
        case StatusesType.mycomment:
          _mycommentList.addAll(statuses);
          _mycommentSink
              .add(UnmodifiableListView<StatusesModel>(_mycommentList));
          break;
        case StatusesType.recentcomment:
          _replymeList.addAll(statuses);
          _replymeSink.add(UnmodifiableListView<StatusesModel>(_replymeList));
          break;
        case StatusesType.mention:
          break;
        case StatusesType.comment:
          break;
        default:
          break;
      }

      _sendEvent(type: type, labId: labId, obj: statuses);
    } catch (e) {
      switch (statusesType) {
        case StatusesType.all:
          _allPageIndex--;
          break;
        case StatusesType.following:
          _followingPageIndex--;
          break;
        case StatusesType.my:
          _mycommentPageIndex--;
          break;
        case StatusesType.mycomment:
          _mycommentPageIndex--;
          break;
        case StatusesType.recentcomment:
          _replymePageIndex--;
          break;
        case StatusesType.mention:
          break;
        case StatusesType.comment:
          break;
        default:
          break;
      }
      _sendEvent(isErr: true, type: type, labId: labId);
    }
  }

  Future getStatusesComments(int id) async {
    _statusescomments.clear();
    var comments = await statusesService.getComments(id);
    if (_statusescomments == null) {
      _statusescomments = new List();
    }
    _statusescomments.addAll(comments);
    _statusesCommentsSink.add(UnmodifiableListView<Map>(_statusescomments));
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
