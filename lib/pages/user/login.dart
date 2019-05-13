import 'package:cnblog/common/constants.dart';
import 'package:cnblog/services/user_sevice.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:cnblog/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.labId}) : super(key: key);

  final String labId;
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserService _userService = new UserService();
  TextEditingController _userNameTextgController = new TextEditingController();
  TextEditingController _pwdTextgController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              child: Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                  child: Container(
                    child: Image.asset('assets/images/avatar_placeholder.png'),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildUsername(),
                      _buildPassword(),
                      _buildLoginButton(),
                    ],
                  ),
                  flex: 2,
                ),
              ]),
            ),
          ),
          // Offstage(
          //   child: _buildListView(),
          //   offstage: !_expand,
          // ),
        ],
      ),
    );
  }

  ///构建账号输入框
  Widget _buildUsername() {
    return Padding(
      padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: Stack(
        alignment: new Alignment(1.0, 1.0),
        //statck
        children: <Widget>[
          new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
              child: new Image.asset(
                'assets/images/icon_username.png',
                width: 40.0,
                height: 40.0,
                fit: BoxFit.fill,
              ),
            ),
            new Expanded(
              child: new TextField(
                controller: _userNameTextgController,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: '请输入用户名',
                ),
              ),
            ),
          ]),
          new IconButton(
            icon: new Icon(Icons.clear, color: Colors.black45),
            onPressed: () {
              _userNameTextgController.clear();
            },
          ),
        ],
      ),
    );
  }

  ///构建密码输入框
  Widget _buildPassword() {
    return Padding(
      padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child:
          new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
          child: new Image.asset(
            'assets/images/icon_password.png',
            width: 40.0,
            height: 40.0,
            fit: BoxFit.fill,
          ),
        ),
        new Expanded(
          child: new TextField(
            controller: _pwdTextgController,
            decoration: new InputDecoration(
              hintText: '请输入密码',
              suffixIcon: new IconButton(
                icon: new Icon(Icons.clear, color: Colors.black45),
                onPressed: () {
                  _pwdTextgController.clear();
                },
              ),
            ),
            obscureText: true,
          ),
        ),
      ]),
    );
  }

  ///构建登录按钮
  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: MaterialButton(
        minWidth: 280.0,
        height: 50.0,
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 22)),
        onPressed: () async {
          var userName = _userNameTextgController.text;
          var passWord = _pwdTextgController.text;
          if (userName == null || userName.isEmpty) {
            showToast("请输入用户名");
            return;
          }

          if (passWord == null || passWord.isEmpty) {
            showToast("请输入密码");
             return;
          }
          // var model = await _userService.login(userName, passWord);
          // if (model == null ||
          //     model.access_token == null ||
          //     model.access_token.isEmpty) {
          //   showToast("用户名或密码错误");
          //    return;
          // }
          SpUtil.setBool(CacheKey.is_login, true);
          NavigatorUtil.pushLoginCallBack(context, labId: widget.labId);
        },
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
