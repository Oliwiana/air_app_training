import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:training/text.dart';
import 'package:weather/weather.dart';

import 'my_home_page.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({this.weather});

  final Weather? weather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(gradient: getGradientByMood(widget.weather!)
            // color: Colors.cyan,
            // gradient: LinearGradient(
            //     begin: Alignment.centerRight,
            //     end: Alignment.centerLeft,
            //     colors: [Colors.blue, Colors.white70]),
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
          Padding(padding: EdgeInsets.only(top: 45)),
          Image(image: AssetImage('icons/${getIconByMood(widget.weather)}')),
          Padding(padding: EdgeInsets.only(top: 41)),
          Text(
              '${DateFormat.MMMMEEEEd('pl').format(DateTime.now())}, ${widget.weather!.weatherDescription}'
              // Strings.permission,
              ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            ' ${widget.weather!.temperature!.celsius?.floor().toString()}',
            // Strings.permission,
          ),
          Text(
            'Odczuwalna ${widget.weather?.tempFeelsLike?.celsius?.floor().toString()}',
            // Strings.permission,
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Cisnienie'),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(('${widget.weather?.pressure?.floor()} hPa'))
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
                      Text('Wiatr'),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(
                          ('${widget.weather?.windSpeed?.floor().toString()} m/s'))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 24)),
          if (widget.weather?.rainLastHour != null)
            Text('Opady: ${widget.weather?.rainLastHour} mn/'),
          Padding(padding: EdgeInsets.only(top: 68))
        ],
      ),
    );
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
                  onPressed: () {
                    Get.to(() => MyHomePage());
                  },
                ))));
  }

  String? getIconByMood(Weather? weather) {
    var main = weather?.weatherMain;
    if (main == 'Clouds' || main == 'Drizzle' || main == 'Snow') {
      return 'weather-rain.png';
    } else if (main == 'Thunderstorm.png') {
      return 'weather-lighting';
    } else if (isNight(weather!)) {
      return 'weather-moonny.png';
    } else {
      return 'weather-sunny.png';
    }
  }

  bool isNight(Weather weather) {
    return DateTime.now().isAfter(weather.sunset!) ||
        DateTime.now().isAfter(weather.sunrise!);
  }

  getGradientByMood(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Clouds' || main == 'Drizzle' || main == 'Snow') {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.blue, Colors.white70]);
    } else if (main == 'Thunderstorm' || isNight(weather)) {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.indigo, Colors.indigoAccent]);
    } else {
      return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Colors.yellowAccent, Colors.white70]);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pl_PL', '');
  }
}
