import 'package:flutter/material.dart';
import '../../components/SearchInput.dart';
import '../../common/const/strings.dart';
import 'statuses_all_page.dart';
import '../../utils/data_util.dart';
import '../user/login.dart';
import 'package:cnblog/components/logindialog.dart';

class StatusesPage extends StatefulWidget {
  @override
  _StatusesPageState createState() => _StatusesPageState();
}

class _StatusesPageState extends State<StatusesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _usernameController;
  TextEditingController _pwdController;

  void _tabControllerListener() async {
    if (_tabController.indexIsChanging) {
      //判断TabBar是否切换
      if (_tabController.index > 0 && (await DataUtils.isLogin()) == false) {
        showDialog(
            context: context,
            builder: (_) => LoginDialog(
                  userNameTextgController: _usernameController,
                  pwdTextgController: _pwdController,
                  onCancelButtonPressed: () {
                    _tabController.animateTo(0); //切换Tabbar
                    Navigator.of(context).pop();
                  },
                  onOkButtonPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
                        builder: (context) {
                      return LoginPage();
                    }));
                  },
                ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 5);
    _tabController.addListener(_tabControllerListener);

    _usernameController = new TextEditingController();
    _pwdController = new TextEditingController();
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearchInput(context),
        elevation: 0.0,
        bottom: TabBar(
          controller: _tabController,
          // indicatorColor: Colors.black,
          tabs: <Widget>[
            Tab(text: Strings.allStatuses), //全站
            Tab(text: Strings.follow), //关注
            Tab(text: Strings.my), //我的
            Tab(text: Strings.mycomment), //我回应
            Tab(text: Strings.replyMe) //回复我
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          StatusesAllPage(),
          Container(color: Colors.green),
          Container(color: Colors.grey),
          Container(color: Colors.pink),
          Container(color: Colors.purple)
        ],
      ),
    );
  }

  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        return null;
        // List<WidgetPoint> list = await widgetControl.search(value);

        // return list
        //     .map((item) => new MaterialSearchResult<String>(
        //           value: item.name,
        //           icon: WidgetName2Icon.icons[item.name] ?? null,
        //           text: 'widget',
        //           onTap: () {
        //             onWidgetTap(item, context);
        //           },
        //         ))
        //     .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
  }
}
