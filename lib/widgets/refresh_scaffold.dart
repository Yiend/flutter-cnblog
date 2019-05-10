import 'package:flutter/material.dart';
import 'package:cnblog/widgets/widget_package.dart';
import 'package:cnblog/widgets/widget_loading.dart';

typedef void OnLoadMore();

class RefreshScaffold extends StatefulWidget {
  const RefreshScaffold(
      {Key key,
      this.labId,
      this.isLoading,
      @required this.controller,
      this.enablePullUp: true,
      this.onRefresh,
      this.onLoadMore,
      this.child,
      this.itemCount,
      this.itemBuilder})
      : super(key: key);

  final String labId;
  final bool isLoading;
  final RefreshController controller;
  final bool enablePullUp;
  final RefreshCallback onRefresh;
  final OnLoadMore onLoadMore;
  final Widget child;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  _RefreshScaffoldState createState() => _RefreshScaffoldState();
}

class _RefreshScaffoldState extends State<RefreshScaffold>
    with AutomaticKeepAliveClientMixin {
  bool isShowFloatBtn = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.scrollController.addListener(() {
        int offset = widget.controller.scrollController.offset.toInt();
        if (offset < 480 && isShowFloatBtn) {
          isShowFloatBtn = false;
          setState(() {});
        } else if (offset > 480 && !isShowFloatBtn) {
          isShowFloatBtn = true;
          setState(() {});
        }
      });
    });
  }

  Widget _buildFloatingActionButton() {
    if (widget.controller.scrollController == null ||
        widget.controller.scrollController.offset < 480) {
      return null;
    }

    return new FloatingActionButton(
        heroTag: widget.labId,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.keyboard_arrow_up,
        ),
        onPressed: () {
          widget.controller.scrollController.animateTo(0.0,
              duration: new Duration(milliseconds: 300), curve: Curves.linear);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            RefreshIndicator(
              child: new SmartRefresher(
                  // header: ClassicHeader(
                  //   releaseText: '',
                  //   completeText: '刷新成功',
                  //   failedText: '',
                  //   idleText: '下拉刷新',
                  //   refreshingText: '正在加载',
                  // ),
                  footer: ClassicFooter(
                    noDataText: '没有更多数据',
                    loadingText: '加载中',
                    idleText: '加载更多',
                    onClick: () {
                      if (widget.controller.footerStatus == LoadStatus.idle)
                        widget.controller.requestLoading();
                    },
                  ),
                  controller: widget.controller,
                  enablePullDown: false,
                  enableOverScroll: false,
                  enablePullUp: widget.enablePullUp,
                  onLoading: widget.onLoadMore,
                  onRefresh: widget.onRefresh,
                  child: widget.child ??
                      new ListView.builder(
                        itemCount: widget.itemCount,
                        itemBuilder: widget.itemBuilder,
                      )),
              onRefresh: widget.onRefresh
                 // Future.delayed(const Duration(milliseconds: 300)),
            ),
            new Offstage(
                offstage: widget.isLoading != true, child: CoolLoading())
          ],
        ),
        floatingActionButton: _buildFloatingActionButton());
  }

  @override
  bool get wantKeepAlive => true;
}
