import 'dart:collection';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/questions_model.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/services/questions_service.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

class QuestionsBloc implements BlocBase {
  final QuestionsService questionsService = new QuestionsService();

  //nosolved
  BehaviorSubject<List<Questions>> _nosolved =
      BehaviorSubject<List<Questions>>();
  Sink<List<Questions>> get _nosolvedSink => _nosolved.sink;
  Stream<List<Questions>> get nosolvedStream => _nosolved.stream;
  int _nosolvedPageIndex = 1;
  List<Questions> _nosolvedList;

  //highscore
  BehaviorSubject<List<Questions>> _highscore =
      BehaviorSubject<List<Questions>>();
  Sink<List<Questions>> get _highscoreSink => _highscore.sink;
  Stream<List<Questions>> get highscoreStream => _highscore.stream;
  int _highscorePageIndex = 1;
  List<Questions> _highscoreList;

  //noanswer
  BehaviorSubject<List<Questions>> _noanswer =
      BehaviorSubject<List<Questions>>();
  Sink<List<Questions>> get _noanswerSink => _noanswer.sink;
  Stream<List<Questions>> get noanswerStream => _noanswer.stream;
  int _noanswerPageIndex = 1;
  List<Questions> _noanswerList;

  //solved
  BehaviorSubject<List<Questions>> _solved = BehaviorSubject<List<Questions>>();
  Sink<List<Questions>> get _solvedSink => _solved.sink;
  Stream<List<Questions>> get solvedStream => _solved.stream;
  int _solvedPageIndex = 1;
  List<Questions> _solvedList;

  //myquestion
  BehaviorSubject<List<Questions>> _myquestion =
      BehaviorSubject<List<Questions>>();
  Sink<List<Questions>> get _myquestionSink => _myquestion.sink;
  Stream<List<Questions>> get myquestionStream => _myquestion.stream;
  int _myquestionPageIndex = 1;
  List<Questions> _myquestionList;

  @override
  BehaviorSubject<StatusEvent> event = new BehaviorSubject<StatusEvent>();

  @override
  Sink<StatusEvent> get eventSink => event.sink;

  @override
  Stream<StatusEvent> get eventStream => event.stream.asBroadcastStream();

  @override
  void dispose() {
    event.close();
    _nosolved.close();
    _highscore.close();
    _noanswer.close();
    _solved.close();
    _myquestion.close();
  }

  @override
  Future getData(RefreshType type, {String labId, int page}) {
    switch (labId) {
      case LanguageKey.tab_questions_nosolved:
        if (_nosolvedList == null) {
          _nosolvedList = new List();
        }
        if (page == 1) {
          _nosolvedList.clear();
        }
        _getData(QuestionsType.nosolved, labId, type, page);
        break;
      case LanguageKey.tab_questions_highscore:
        if (_highscoreList == null) {
          _highscoreList = new List();
        }
        if (page == 1) {
          _highscoreList.clear();
        }
        _getData(QuestionsType.highscore, labId, type, page);
        break;
      case LanguageKey.tab_questions_noanswer:
        if (_noanswerList == null) {
          _noanswerList = new List();
        }
        if (page == 1) {
          _noanswerList.clear();
        }
        _getData(QuestionsType.noanswer, labId, type, page);
        break;
      case LanguageKey.tab_questions_solved:
        if (_solvedList == null) {
          _solvedList = new List();
        }
        if (page == 1) {
          _solvedList.clear();
        }
        _getData(QuestionsType.solved, labId, type, page);
        break;
      case LanguageKey.tab_questions_myquestion:
        if (_myquestionList == null) {
          _myquestionList = new List();
        }
        if (page == 1) {
          _myquestionList.clear();
        }
        _getData(QuestionsType.myquestion, labId, type, page);
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
      case LanguageKey.tab_questions_nosolved:
        _page = ++_nosolvedPageIndex;
        break;
      case LanguageKey.tab_questions_highscore:
        _page = ++_highscorePageIndex;
        break;
      case LanguageKey.tab_questions_noanswer:
        _page = ++_noanswerPageIndex;
        break;
      case LanguageKey.tab_questions_solved:
        _page = ++_solvedPageIndex;
        break;
      case LanguageKey.tab_questions_myquestion:
        _page = ++_myquestionPageIndex;
        break;
      default:
        break;
    }
    return getData(RefreshType.load, labId: labId, page: _page);
  }

  @override
  Future onRefresh({String labId}) {
    switch (labId) {
      case LanguageKey.tab_questions_nosolved:
        _nosolvedPageIndex = 1;
        break;
      case LanguageKey.tab_questions_highscore:
        _highscorePageIndex = 1;
        break;
      case LanguageKey.tab_questions_noanswer:
        _noanswerPageIndex = 1;
        break;
      case LanguageKey.tab_questions_solved:
        _solvedPageIndex = 1;
        break;
      case LanguageKey.tab_questions_myquestion:
        _myquestionPageIndex = 1;
        break;
      default:
        break;
    }
    return getData(RefreshType.refresh, labId: labId, page: 1);
  }

  Future _getData(QuestionsType questionsType, String labId, RefreshType type,
      int page) async {
    var statuses =
        await questionsService.getQuestions(questionsType, pageIndex: page);
    try {
      switch (questionsType) {
        case QuestionsType.nosolved:
          _nosolvedList.addAll(statuses);
          _nosolvedSink.add(UnmodifiableListView<Questions>(_nosolvedList));
          break;
        case QuestionsType.highscore:
          _highscoreList.addAll(statuses);
          _highscoreSink.add(UnmodifiableListView<Questions>(_highscoreList));
          break;
        case QuestionsType.noanswer:
          _noanswerList.addAll(statuses);
          _noanswerSink.add(UnmodifiableListView<Questions>(_noanswerList));
          break;
        case QuestionsType.solved:
          _solvedList.addAll(statuses);
          _solvedSink.add(UnmodifiableListView<Questions>(_solvedList));
          break;
        case QuestionsType.myquestion:
          _myquestionList.addAll(statuses);
          _myquestionSink.add(UnmodifiableListView<Questions>(_myquestionList));
          break;
        default:
          break;
      }

      _sendEvent(type: type, labId: labId, obj: statuses);
    } catch (e) {
      switch (questionsType) {
        case QuestionsType.nosolved:
          _nosolvedPageIndex--;
          break;
        case QuestionsType.highscore:
          _highscorePageIndex--;
          break;
        case QuestionsType.noanswer:
          _noanswerPageIndex--;
          break;
        case QuestionsType.solved:
          _solvedPageIndex--;
          break;
        case QuestionsType.myquestion:
          _myquestionPageIndex--;
          break;
        default:
          break;
      }
      _sendEvent(isErr: true, type: type, labId: labId);
    }
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
