import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CoolLoading extends StatelessWidget {
  const CoolLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: 24.0,
        height: 24.0,
        child: new CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
    // return Container(
    //   alignment: Alignment.center,
    //   color: Colors.white,
    //   width: 300.0,
    //   height: 300.0,
    //   child: SpinKitFadingCircle(
    //     itemBuilder: (_, int index) {
    //       return DecoratedBox(
    //         decoration: BoxDecoration(
    //           color: index.isEven ? Colors.red : Colors.green,
    //         ),
    //       );
    //     },
    //     size: 120.0,
    //   ),
    // );
  }
}
