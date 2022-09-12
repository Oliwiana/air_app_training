import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:training/splash_form_controller.dart';
import 'package:training/text.dart';

class SplashScreen extends GetView<SplashFormController> {


  @override
  Widget build(BuildContext context) {
    // Future.delayed(
    //     const Duration(seconds:4),
    //     () => {
    //           if (havePermissions())
    //             {Get.offAndToNamed('/permissions')}
    //           else
    //             {Get.offAndToNamed('/home')}
    //         });
    return Scaffold(
        body: Center(child: GetBuilder<SplashFormController>(builder: (_) {
      return Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.white30, Colors.white10]),
          ),
        ),
        splash1(_),
        splash2()
      ]);
    })));
  }

  Widget splash1(_) {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Neumorphic(
              style: NeumorphicStyle(
                color: Colors.white,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),

                depth: 4,
                intensity: 0.8,
                surfaceIntensity: 0.40,

                lightSource: LightSource.top,

                // border: NeumorphicBorder(
                //   color: Colors.blue,
                //   width: 0.4,
                //
                // ),
              ),
              // child: FadeTransition(
              //     // opacity: _.animation,
              //     child: const Padding(
              //         padding: EdgeInsets.all(8),
              //         child: Image(image: AssetImage('icons/img_15.png'))))
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          // NeumorphicText(
          //   style: NeumorphicStyle(
          //     depth: 4,  //customize depth here
          //     intensity: 0.3,
          //
          //     color: Colors.lightBlueAccent, //customize color here
          //   ),
          //   Strings.appTitle.toUpperCase(),
          //   textStyle: NeumorphicTextStyle(fontSize: 40, ),
          // ),
          Padding(padding: EdgeInsets.only(top: 15)),
          NeumorphicText(
            style: NeumorphicStyle(
              depth: 4, //customize depth here
              intensity: 0.3,

              color: Colors.blue[900], //customize color here
              //   )
            ),
            textAlign: TextAlign.center,
            Strings.splashCenter,
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget splash2() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 35,
        child: Container(
            alignment: Alignment.center,
            child: Text(
              Strings.splashBottom,
              style: TextStyle(color: Colors.indigoAccent),
            )));
  }


  bool havePermissions() {
    return true;
  }
}
