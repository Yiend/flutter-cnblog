import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/questions_bloc.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/model/questions_model.dart';
import 'package:cnblog/utils/sp_util.dart';
import 'package:cnblog/widgets/questions_item.dart';
import 'package:cnblog/widgets/refresh_scaffold.dart';
import 'package:cnblog/widgets/widget_nologin.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/model/enums.dart';
import 'package:rxdart/rxdart.dart';

bool isStatusesFollowInit = true;

class TabQuestionsPage extends StatelessWidget {
  const TabQuestionsPage({Key key, this.labId, this.questionsType})
      : super(key: key);
  final String labId;
  final QuestionsType questionsType;

  @override
  Widget build(BuildContext context) {
    if (SpUtil.getBool(CacheKey.is_login) == false) {
      return NoLogin(labId: labId);
    }

    RefreshController _controller = new RefreshController();
    final QuestionsBloc questionsBloc = BlocProvider.of<QuestionsBloc>(context);

    questionsBloc.eventStream.listen((event) {
      if (labId == event.labId) {
        switch (event.type) {
          case RefreshType.refresh:
            if (event.status == RefreshStatus.failed.index) {
              _controller.refreshFailed();
            }
            if (event.status == RefreshStatus.completed.index) {
              _controller.refreshCompleted();
            }
            break;
          case RefreshType.load:
            if (event.status == LoadStatus.noMore.index) {
              _controller.loadNoData();
            }
            if (event.status == LoadStatus.idle.index) {
              _controller.loadComplete();
            }
            break;
          default:
        }
      }
    });

    if (isStatusesFollowInit) {
      isStatusesFollowInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        questionsBloc.onRefresh(labId: labId);
      });
    }

    return new StreamBuilder(
        stream: getStream(questionsBloc),
        builder:
            (BuildContext context, AsyncSnapshot<List<Questions>> snapshot) {
          return new RefreshScaffold(
            labId: labId,
            isLoading: snapshot.data == null,
            controller: _controller,
            onRefresh: () {
              return questionsBloc.onRefresh(labId: labId);
            },
            onLoadMore: () {
              questionsBloc.onLoadMore(labId: labId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var model = snapshot.data[index];
              return QuestionsItem(question: model, labId: labId);
            },
          );
        });
  }

  Stream<List<Questions>> getStream(QuestionsBloc bloc) {
    switch (this.questionsType) {
      case QuestionsType.nosolved:
        return bloc.nosolvedStream;
      case QuestionsType.highscore:
        return bloc.highscoreStream;
      case QuestionsType.noanswer:
        return bloc.noanswerStream;
      case QuestionsType.solved:
        return bloc.solvedStream;
      case QuestionsType.myquestion:
        return bloc.myquestionStream;
      default:
    }
  }
}
