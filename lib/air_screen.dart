import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:training/splash_form_controller.dart';

class AirScreen extends StatefulWidget {
  AirScreen({this.air});

  final AirQuality? air;

  @override
  State<AirScreen> createState() => _AirScreenState();
}

class _AirScreenState extends State<AirScreen> {
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: GetBuilder<SplashFormController>(builder: (_) {
      return Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: getGradientByMood(widget.air!),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 120,),
        text1(),
        text2(),
        // humity(),
        splash1(_),
        circle(),

        // splash2()
      ])]);
    })));
  }

  Widget splash1(_) {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        children: <Widget>[
          Text(
            'Jakosc powietrza',
            style: TextStyle(color: getBackgroundTextColor(widget.air!)),
          ),

          Padding(padding: EdgeInsets.only(top: 24)),
          Text(widget.air!.quality),

          // Padding(padding: EdgeInsets.only(top: 24)),

          // NeumorphicText(
          //   style: NeumorphicStyle(
          //     depth: 4, //customize depth here
          //     intensity: 0.3,
          //
          //     color: Colors.blue[900], //customize color here
          //     //   )
          //   ),
          //   textAlign: TextAlign.center,
          //   Strings.splashCenter,
          //   textStyle: NeumorphicTextStyle(
          //     fontSize: 20,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget humity() {
    return Container(
      height: 180,
      child: Column(
        children: [
          Center(
            child: SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: 72,
              appearance: CircularSliderAppearance(
                animationEnabled: false,
                customWidths: CustomSliderWidths(
                  handlerSize: 0,
                  trackWidth: 12,
                  progressBarWidth: 12,
                ),
                size: 130,
                customColors: CustomSliderColors(
                  // progressBarColors: ,
                  trackColor: Color(0xffF4F4F8),
                  dynamicGradient: true,
                  hideShadow: true,
                ),
                infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(
                      letterSpacing: 0.1,
                      height: 1.0,
                      fontSize: 27,
                      fontFamily: 'MohrRounded',
                    ),
                    bottomLabelText: ('Humidity'),
                    bottomLabelStyle: TextStyle(
                      letterSpacing: 0.1,
                      height: 1.4,
                      fontSize: 14,
                      fontFamily: 'MohrRounded',
                    )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Feels Like',
                      style: TextStyle(
                        fontFamily: 'MohrRounded',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 0.8,
                        color: Color(0xffBDBCE1),
                      ),
                    ),
                    TextSpan(
                      text: ' 10°',
                      style: TextStyle(
                        fontFamily: 'MohrRounded',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 0.8,
                        color: Color(0xff171717),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                height: 25,
                width: 1,
                color: Color(0xffE4E4EE),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'UV Index',
                      style: TextStyle(
                        fontFamily: 'MohrRounded',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 0.8,
                        color: Color(0xffBDBCE1),
                      ),
                    ),
                    TextSpan(
                      text: ' 0 low',
                      style: TextStyle(
                        fontFamily: 'MohrRounded',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 0.8,
                        color: Color(0xff171717),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget circle() {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (widget.air!.aqi / 200 * 100).floor().toString(),
              textAlign: TextAlign.center,
            ),
            RichText(
                text: TextSpan(
              text: 'CAQI',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _pc.open();
                },
            )),
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
              'AIR',
              style: TextStyle(color: Colors.indigoAccent),
            )));
  }

  Widget text1() {
    return  Column(
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  child: Column(
                    children: [
                      Text('PM 2.5'),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text((widget.air!.pm25.toString() + '%'))
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 48,
                  thickness: 1,
                ),
                Container(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('PM 10'),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text((widget.air!.pm10.toString() + '%'))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text('Stacja pomiarowa'),
          Text(widget.air!.station),
        ],

    );
  }

  Widget text2() {
    return Container(
            // alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                // ClipRect(
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     heightFactor: 1,
                //     child: getDangerValueBottom(widget.air!),
                //   ),
                // ),
                // ClipRect(
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     heightFactor: 1 - widget.air!.aqi / 200.floor(),
                //     child:
                    getDangerValueTop(widget.air!),
                  // ),
                // ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 100, left: 10, right: 10, bottom: 3),
                            // child: Divider(
                            //   height: 10,
                            //   color: Colors.black,
                            //   thickness: 1,
                            // ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 100, left: 10, right: 10, bottom: 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Container(
                                color: Colors.white,
                                child: Text(widget.air!.advice),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                SlidingUpPanel(
                    controller: _pc,
                    minHeight: 0,
                    maxHeight: 340,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    panel: Stack(fit: StackFit.expand, children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 32)),
                            Text(
                              'Indeks CAQI',
                              style: TextStyle(),
                            ),
                            Text(
                                'Indeks CAQI (ang. Common Air Quality Index) pozwala przedstawić sytuację w Europiie w porównywalny i łatwy do zrozumienia sposób. Wartość indeksu jest prezentowana w postaci jednej liczby. Skala ma rozpietość od 0 do wartości powyżej 100 i powyżej bardzo zanieczyszone. Im wyższa wartość wskażnika, tym większe ryzyko złego wpływu na zdrowie i sampoczucie.'),
                            Text('Pył zawieszony PM2,5 i PM10'),
                            Text(
                                'Pyły zawieszone to mieszanina bardzo małych cząstek. PM10 to wszystkie pyły mniejsze niz 10μm, natomiast w przypadku  PM2,5 nie większe niż 2,5μm. Zanieczyszczenia pyłowe mają zdolność do adsorpcji swojej powierzchni innych, bardzo szkodliwych związków chemicznych: dioksyn, furanów, metali ciężkich, czy benzo(a)pirenu - najbardziej toksycznego skłądnika smogu.'),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 16)),
                                onPressed: () {
                                  _pc.close();
                                },
                                child: Icon(Icons.check),
                              )))
                    ]))
              ],
            ));
  }

  LinearGradient getGradientByMood(AirQuality air) {
    if (air.isGood) {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.greenAccent, Colors.green]);
    } else if (air.isBad) {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.orange, Colors.deepOrange]);
    } else {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.red, Colors.red]);
    }
  }

  getBackgroundTextColor(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  getDangerValueBottom(AirQuality air) {
    if (air.isGood || air.isBad) {
      return Image.asset(
        'icons/danger-value-negative.png',
        scale: 0.9,
      );
    } else {
      return Image.asset(
        'icons/danger-value.png',
        scale: 0.9,
      );
    }
  }

  getDangerValueTop(AirQuality air) {
    if (air.isGood) {
      return Image.asset(
        'icons/danger-value-negative.png',
        scale: 0.9,
        color: Colors.green,
      );
    } else if (air.isBad) {
      return Image.asset(
        'icons/danger-value-negative.png',
        scale: 0.9,
        color: Colors.deepOrangeAccent,
      );
    } else {
      return Image.asset(
        'icons/danger-value-negative.png',
        scale: 0.9,
        color: Colors.red,
      );
    }
  }

  getAdviceImage(AirQuality air) {
    if (air.isGood) {
      return Icon(Icons.check);
    } else if (air.isBad) {
      return Icon(Icons.minimize);
    } else {
      return Icon(Icons.accessibility_new_sharp);
    }
  }
}
