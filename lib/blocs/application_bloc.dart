import 'dart:async';

import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:rxdart/rxdart.dart';
import 'package:connectivity/connectivity.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();
  Sink<int> get _appEventSink => _appEvent.sink;
  Stream<int> get appEventStream => _appEvent.stream;

  //final Connectivity connectivity = Connectivity();

  // BehaviorSubject<ConnectivityResult> _appNetWorkStatus =
  //     BehaviorSubject<ConnectivityResult>();
  // Sink<ConnectivityResult> get _appNetWorkStatusSink => _appNetWorkStatus.sink;
  // Stream<ConnectivityResult> get appNetWorkStatusStream =>
  //     _appNetWorkStatus.stream;

  // ApplicationBloc() {
  //   netWorkIsConnect();
  // }

  // Future netWorkIsConnect() async {
  //   try {
  //     var status = await connectivity.checkConnectivity();
  //     _appNetWorkStatusSink.add(status);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    _appEvent.close();
   // _appNetWorkStatus.close();
  }

  @override
  Future getData(RefreshType type, {String labId, int page}) {
    // TODO: implement getData
    return null;
  }

  @override
  Future onLoadMore({String labId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labId}) {
    // TODO: implement onRefresh
    return null;
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }

  @override
  BehaviorSubject<StatusEvent> event = new BehaviorSubject<StatusEvent>();

  @override
  Sink<StatusEvent> get eventSink => event.sink;

  @override
  Stream<StatusEvent> get eventStream => event.stream.asBroadcastStream();
}
