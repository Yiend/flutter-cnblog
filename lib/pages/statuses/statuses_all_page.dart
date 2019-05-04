import 'package:cnblog/pages/statuses/statuses_list_item.dart';
import 'package:flutter/material.dart';
import '../../services/statuses_service.dart';
import '../../model/statuses_model.dart';
import '../../common/const/strings.dart';
import '../../common/const/enums.dart';


class StatusesAllPage extends StatefulWidget {
  @override
  _StatusesAllState createState() => _StatusesAllState();
}

class _StatusesAllState extends State<StatusesAllPage> {

  List<StatusesModel> modules = []; //列表数据
  int page = 1; //加载的页码
  ScrollController _scrollController = new ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据
  StatusesService statusesService;

  Future<List<StatusesModel>> fakeRequest() async {
    var modules = await statusesService.getStatuses(StatusesType.all,this.page, 10);
    return Future.delayed(Duration(milliseconds: 300), () {
      return modules;
    });
  }

  /* 
   下拉刷新
  */
  Future<void> _onRefresh() async {
    var modules = await statusesService.getStatuses(StatusesType.all,1, 10);
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        this.modules = modules;
      });
    });
  }

  /* 
  上拉加载更多
 */
  _getMoreData() async {
    if (!isLoading) {
      setState(() => isLoading = true);

      List<StatusesModel> newEntries = await fakeRequest(); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        modules.addAll(newEntries);
        isLoading = false;
        page++;
      });
    }
  }

  /*
  获取第一页的数据
  */
  Future<void> getFirstData() async {
    var modules = await statusesService.getStatuses(StatusesType.all,page, 10);
    setState(() {
      this.modules = modules;
      page++;
    });
  }

  Widget buildModule(BuildContext context, StatusesModel module) {
    return StatusesListItem(
       statusesModel: module,
       title: Strings.allStatuses,
    );
  }

  Widget _buildProgressIndicator() {
    if (modules.length > 0) {
      return new Padding(
        padding: const EdgeInsets.all(18.0),
        child: new Center(
          child: new Opacity(
            opacity: isLoading ? 1.0 : 0.0,
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return havaNoMore();
    }
  }

  Widget havaNoMore() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
          child: Text(
            "没有更过内容了，去别的地方看看吧(^_^)",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: modules.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == modules.length) {
            return _buildProgressIndicator();
          } else {
            return buildModule(context, modules[index]);
          }
        },
        controller: _scrollController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    statusesService = new StatusesService();
    getFirstData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
