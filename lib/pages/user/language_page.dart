import 'package:cnblog/blocs/application_bloc.dart';
import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/common/sp_helper.dart';
import 'package:cnblog/model/language_model.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/utils/object_util.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LanguagePageState();
  }
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> _list = new List();

  LanguageModel _currentLanguage;

  @override
  void initState() {
    super.initState();

    _list.add(LanguageModel(LanguageKey.languageZH, 'zh', 'CH'));
    _list.add(LanguageModel(LanguageKey.languageEN, 'en', 'US'));

    _currentLanguage = SpHelper.getObject<LanguageModel>(LanguageKey.language);
    if (ObjectUtil.isEmpty(_currentLanguage)) {
      _currentLanguage = _list[0];
    }

    _updateData();
  }

  void _updateData() {
    String language = _currentLanguage.countryCode;
    for (int i = 0, length = _list.length; i < length; i++) {
      _list[i].isSelected = (_list[i].countryCode == language);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          IntlUtil.getString(context, LanguageKey.page_language),
          style: new TextStyle(fontSize: 16.0),
        ),
        actions: [
          new Padding(
            padding: EdgeInsets.all(12.0),
            child: new SizedBox(
              width: 64.0,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Colors.indigoAccent,
                child: Text(
                  IntlUtil.getString(context, LanguageKey.save),
                  style: new TextStyle(fontSize: 12.0),
                ),
                onPressed: () {
                  SpHelper.setObject(
                      LanguageKey.language,
                      ObjectUtil.isEmpty(_currentLanguage.languageCode)
                          ? null
                          : _currentLanguage);
                  bloc.sendAppEvent(1);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: new ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            LanguageModel model = _list[index];
            return new ListTile(
              title: new Text(
                (IntlUtil.getString(context, model.titleId,
                        languageCode: 'zh', countryCode: 'CH')),
                style: new TextStyle(fontSize: 13.0),
              ),
              trailing: new Radio(
                  value: true,
                  groupValue: model.isSelected == true,
                  activeColor: Colors.indigoAccent,
                  onChanged: (value) {
                    setState(() {
                      _currentLanguage = model;
                      _updateData();
                    });
                  }),
              onTap: () {
                setState(() {
                  _currentLanguage = model;
                  _updateData();
                });
              },
            );
          }),
    );
  }
}
