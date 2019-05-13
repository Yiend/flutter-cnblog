import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnblog/model/userinfo_model.dart';
import 'package:cnblog/pages/user/about_page.dart';
import 'package:cnblog/pages/user/setting_page.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/services/user_sevice.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserService _userService = new UserService();
  List<PageInfo> _pageInfo = new List();
  UserInfo userInfo;

  Future getUserInfo() async {
    var user = await _userService.getUserInfo();
    setState(() {
      userInfo = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    
    _pageInfo
        .add(PageInfo(LanguageKey.page_setting, Icons.settings, SettingPage()));
    _pageInfo.add(PageInfo(LanguageKey.page_about, Icons.info, AboutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            // padding: EdgeInsets.only(
            //     top: ScreenUtil.getInstance().statusBarHeight, left: 10.0),
            child: new SizedBox(
              height: 120.0,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        width: 64.0,
                        height: 64.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(userInfo.avatar==null?"":userInfo.avatar),
                          ),
                        ),
                      ),
                      new Text(userInfo.displayName,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        "园龄：${userInfo.seniority}",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ],
                  ),
                  new Align(
                    alignment: Alignment.topRight,
                    child: new IconButton(
                        iconSize: 18.0,
                        icon: new Icon(Icons.edit, color: Colors.white),
                        onPressed: () {}),
                  )
                ],
              ),
            ),
          ),
          new Container(
            height: 50.0,
            child: new Material(
              color: Colors.grey[200],
              child: new InkWell(
                child: new Center(
                  child: new Text(
                    "",
                    style: new TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: new ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: _pageInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  PageInfo pageInfo = _pageInfo[index];
                  return new ListTile(
                    leading: new Icon(pageInfo.iconData),
                    title:
                        new Text(IntlUtil.getString(context, pageInfo.titleId)),
                    onTap: () {
                      NavigatorUtil.pushPage(context, pageInfo.page,
                          pageName: pageInfo.titleId);
                    },
                  );
                }),
            flex: 1,
          )
        ],
      ),
    );
  }
}
