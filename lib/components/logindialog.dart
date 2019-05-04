import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  final double _cornerRadius = 8.0;
  final double _buttonRadius = 5.0;
  final VoidCallback onOkButtonPressed;
  final VoidCallback onCancelButtonPressed;
  final TextEditingController userNameTextgController;
  final TextEditingController pwdTextgController;

  LoginDialog(
      {Key key,
      @required this.onOkButtonPressed,
      this.onCancelButtonPressed,
      this.userNameTextgController,
      this.pwdTextgController})
      : super(key: key);

  @override
  _LoginDialogState createState() => new _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget._cornerRadius)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: (MediaQuery.of(context).size.height / 2) * 0.6,
                  child: Card(
                    elevation: 0.0,
                    margin: EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(widget._cornerRadius),
                            topLeft: Radius.circular(widget._cornerRadius))),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset('assets/images/login.gif',
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("登  录",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  child: Stack(
                    alignment: new Alignment(1.0, 1.0),
                    //statck
                    children: <Widget>[
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Padding(
                              padding:
                                  new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: new Image.asset(
                                'assets/images/icon_username.png',
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.fill,
                              ),
                            ),
                            new Expanded(
                              child: new TextField(
                                controller: widget.userNameTextgController,
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
                          widget.userNameTextgController.clear();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                            controller: widget.pwdTextgController,
                            decoration: new InputDecoration(
                              hintText: '请输入密码',
                              suffixIcon: new IconButton(
                                icon: new Icon(Icons.clear, color: Colors.black45),
                                onPressed: () {
                                  widget.pwdTextgController.clear();
                                },
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 0.0),
              //padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(widget._buttonRadius)),
                    onPressed: widget.onCancelButtonPressed ??
                        () => Navigator.of(context).pop(),
                    child: Text('取消', style: TextStyle(color: Colors.white)),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(widget._buttonRadius)),
                    onPressed: widget.onOkButtonPressed ?? () {},
                    child: Text('登录', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
