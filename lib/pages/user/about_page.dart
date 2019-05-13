import 'package:cnblog/resources/colors.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/resources/styles.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, LanguageKey.page_about)),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
              height: 160.0,
              alignment: Alignment.center,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(width: 0.33, color: AppColors.divider))),
          new ComArrowItem("作者","叶秋"),
          new ComArrowItem("邮箱","wirehomedev@gmail.com"),
        ],
      ),
    );
  }
}


class ComArrowItem extends StatelessWidget {
  const ComArrowItem(this.title,this.extra,{Key key}) : super(key: key);
  final String title;
  final String extra;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Material(
        color: Colors.white,
        child: new ListTile(
          title: new Text(title),
          trailing: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                extra,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              new Icon(
                Icons.navigate_next,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      decoration: Decorations.bottom,
    );
  }
}