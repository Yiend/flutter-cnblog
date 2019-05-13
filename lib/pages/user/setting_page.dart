import 'package:cnblog/common/sp_helper.dart';
import 'package:cnblog/model/language_model.dart';
import 'package:cnblog/pages/user/language_page.dart';
import 'package:cnblog/resources/colors.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/utils/navigator_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageModel languageModel =
        SpHelper.getObject<LanguageModel>(LanguageKey.language);
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          IntlUtil.getString(context, LanguageKey.page_setting),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // new ExpansionTile(
          //   title: new Row(
          //     children: <Widget>[
          //       Icon(
          //         Icons.color_lens,
          //         color: AppColors.gray_66,
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.0),
          //         child: Text(
          //           IntlUtil.getString(context, Ids.titleTheme),
          //         ),
          //       )
          //     ],
          //   ),
          //   children: <Widget>[
          //     new Wrap(
          //       children: themeColorMap.keys.map((String key) {
          //         Color value = themeColorMap[key];
          //         return new InkWell(
          //           onTap: () {
          //             SpUtil.putString(Constant.key_theme_color, key);
          //             bloc.sendAppEvent(Constant.type_sys_update);
          //           },
          //           child: new Container(
          //             margin: EdgeInsets.all(5.0),
          //             width: 36.0,
          //             height: 36.0,
          //             color: value,
          //           ),
          //         );
          //       }).toList(),
          //     )
          //   ],
          // ),
          new ListTile(
            title: new Row(
              children: <Widget>[
                Icon(
                  Icons.language,
                  color: AppColors.gray_66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    IntlUtil.getString(context, LanguageKey.page_language),
                  ),
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    IntlUtil.getString(context, languageModel.titleId,
                            languageCode: 'zh', countryCode: 'CH'),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.gray_99,
                    )),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              NavigatorUtil.pushPage(context, LanguagePage(),
                  pageName: LanguageKey.page_language);
            },
          )
        ],
      ),
    );
  }
}
