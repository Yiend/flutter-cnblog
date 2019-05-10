import 'package:flutter/material.dart';
import 'package:cnblog/utils/timer_util.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TimerUtil _timerUtil;

  @override
  void initState() {
    super.initState();
    _doCountDown();
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 2 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed('/AppPage');
  }

  Widget _buildSplashBg() {
    return new Image.asset(
      "assets/images/start_bg.jpg",
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
           _buildSplashBg(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}
