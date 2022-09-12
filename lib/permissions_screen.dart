import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:training/splash_screen.dart';
import 'package:training/text.dart';
import 'package:weather/weather.dart';

import 'my_home_page.dart';

class PermissionScreen extends StatefulWidget {
  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
  late final Weather weather;
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          // color: Colors.cyan,
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.white, Colors.white70]),
        ),
      ),
      text1(),
      text2()
    ]));
  }

  Widget text1() {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('icons/hand-wave.png')),
          Padding(padding: EdgeInsets.only(top: 15)),
          NeumorphicText(
            Strings.permissionGreeting,
            style: NeumorphicStyle(
              depth: 2, //customize depth here
              color: Colors.white70,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 42, //customize size here
              // AND others usual text style properties (fontFamily, fontWeight, ...)
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          NeumorphicText(
            Strings.permission,
            textAlign: TextAlign.center,
            textStyle: NeumorphicTextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}

Widget text2() {
  return Positioned(
      left: 0,
      right: 0,
      bottom: 35,
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          alignment: Alignment.center,
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(top: 12, bottom: 12))),
                child: Text(
                  Strings.permissionAggre,
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  LocationPermission permission =
                      await Geolocator.requestPermission();
                  if (permission == LocationPermission.always ||
                      permission == LocationPermission.whileInUse){
                    Get.to(() => SplashScreen());
                }},
              ))));
}
