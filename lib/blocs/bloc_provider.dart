import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/statusevent.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


 abstract class BlocBase {
  BehaviorSubject<StatusEvent> event;
  Sink<StatusEvent> get eventSink;
  Stream<StatusEvent> get eventStream;

  Future getData(RefreshType type, {String labId, int page});

  Future onRefresh({String labId});

  Future onLoadMore({String labId});

  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
    this.userDispose: true,
  }) : super(key: key);

  final T bloc;
  final Widget child;
  final bool userDispose;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    if (widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
