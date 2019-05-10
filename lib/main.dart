import 'package:cnblog/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';

import 'package:cnblog/pages/app_page.dart';
import 'package:cnblog/pages/start_page.dart';
import 'package:cnblog/common/sp_helper.dart';
import 'package:cnblog/blocs/bloc_provider.dart';
import 'package:cnblog/blocs/application_bloc.dart';
import 'package:cnblog/resources/languages.dart';
import 'package:cnblog/resources/strings.dart';
import 'package:cnblog/model/language_model.dart';
import 'package:cnblog/utils/sp_util.dart';

void main() async {
  final server = Jaguar();
  server.addRoute(serveFlutterAssets());
  await server.serve(logRequests: true);
  server.log.onRecord.listen((r) => print(r));

  runApp(BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(),
    child: MyApp()//BlocProvider(child: MyApp(), bloc: HomeBloc()),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  //Color _themeColor = AppColors.app_main;

  @override
  void initState() {
    super.initState();
    setLocalizedValues(Strings.localizedValues);
    _initAsync();
    _initListener();
  }

  //初始化 shared_preferences 存储
  void _initAsync() async {
    await SpUtil.getInstance();
    if (!mounted) return;
    _loadLocale();
  }

  //初始化 应用bloc 监听，用于更改 主题，多语言等全局设置
  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  //初始化多语言
  void _loadLocale() {
    setState(() {
      LanguageModel model =
          SpHelper.getObject<LanguageModel>(LanguageKey.language);
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }
     
      // String _colorKey = SpHelper.getThemeColor();
      // if (themeColorMap[_colorKey] != null)
      //   _themeColor = themeColorMap[_colorKey];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        '/AppPage': (ctx) => AppPage(),
      },
      home: new StartPage(),
      theme: ThemeData.light().copyWith(
        primaryColorLight: Color(0xFF3865F7), 
        primaryColorDark: Colors.deepPurple[300],
       
        //primaryColor: _themeColor,
        //accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate
      ],
      supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}
