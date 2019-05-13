import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/statuses_bloc.dart';
import 'package:cnblog/common/constants.dart';
import 'package:cnblog/model/statuses_model.dart';
import 'package:cnblog/utils/sp_util.dart';
import 'package:cnblog/widgets/refresh_scaffold.dart';
import 'package:cnblog/widgets/statuses_item.dart';
import 'package:cnblog/widgets/widget_nologin.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:flutter/material.dart';
import 'package:cnblog/model/enums.dart';
import 'package:rxdart/rxdart.dart';

bool isStatusesFollowInit = true;

class StatusesFollowPage extends StatelessWidget {
  const StatusesFollowPage({Key key, this.labId}) : super(key: key);
  final String labId;

@override
  Widget build(BuildContext context) {
    if(SpUtil.getBool(CacheKey.is_login)==false) {
       return NoLogin(labId: labId);
    }

    RefreshController _controller = new RefreshController();
   final StatusesBloc statusesBloc = BlocProvider.of<StatusesBloc>(context);

    statusesBloc.eventStream.listen((event) {
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
        statusesBloc.onRefresh(labId: labId);
      });
    }

    return new StreamBuilder(
        stream: statusesBloc.followingStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<StatusesModel>> snapshot) {
          return new RefreshScaffold(
            labId: labId,
            isLoading: snapshot.data == null,
            controller: _controller,
            onRefresh: () {
              return statusesBloc.onRefresh(labId: labId);
            },
            onLoadMore: () {
              statusesBloc.onLoadMore(labId: labId);
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var model = snapshot.data[index];
              return StatusesItem(statusesModel: model, labId: labId);
            },
          );
        });
  }
}