import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/home_bloc.dart';
import 'package:cnblog/blocs/news_bloc.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/news_model.dart';
import 'package:cnblog/widgets/blog_item.dart';
import 'package:cnblog/widgets/news_item.dart';
import 'package:cnblog/widgets/refresh_scaffold.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:cnblog/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

bool isNewsWeekInit = true;

class NewsWeekPage extends StatelessWidget {
  const NewsWeekPage({Key key, this.labId}) : super(key: key);
  final String labId;

  @override
  Widget build(BuildContext context) {
    RefreshController _controller = new RefreshController();
    final NewsBloc newsbloc = BlocProvider.of<NewsBloc>(context);
    
    newsbloc.eventStream.listen((event) {
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

    if (isNewsWeekInit) {
      isNewsWeekInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        newsbloc.onRefresh(labId: labId);
      });
    }

    return new StreamBuilder(
        stream: newsbloc.weekNewsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
          return new RefreshScaffold(
            labId: labId,
            isLoading: snapshot.data == null,
            controller: _controller,
            onRefresh: () {
              return newsbloc.onRefresh(labId: labId);
            },
            onLoadMore: () {
              newsbloc.onLoadMore(labId: labId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var model = snapshot.data[index];
              return NewsItem(newsModel: model, labId: labId);
            },
          );
        });
  }
}