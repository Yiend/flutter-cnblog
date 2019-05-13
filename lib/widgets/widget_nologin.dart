import 'package:cnblog/pages/user/login.dart';
import 'package:flutter/material.dart';

class NoLogin extends StatelessWidget {
  const NoLogin({Key key, @required this.labId}) : super(key: key);
  final String labId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/no_login.jpg"),
          SizedBox(height: 10.0),
          Text("您还有登录哦~", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  //注意传递的参数。goods_list[index]，是吧索引下的goods_date 数据传递了
                  builder: (context) {
                return LoginPage(labId: labId);
              }));
            },
            child: Text('点击登录', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
