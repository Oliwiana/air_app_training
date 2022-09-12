import 'dart:convert';
import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:training/permissions_screen.dart';
import 'package:weather/weather.dart';

import 'my_home_page.dart';

class SplashFormController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // late AnimationController animationController;
  // late final Animation<double> animation =
  //     CurvedAnimation(parent: animationController, curve: Curves.linear);

  @override
  void onInit() {
    super.onInit();
    // animationController = AnimationController(
    //   duration: const Duration(seconds: 6),
    //   vsync: this,
    // )..repeat(reverse: true);
    checkPermission();
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.to(() => PermissionScreen());
    } else {
      SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
        executeOnceAfterBuild();
      });
    }
  }

  void executeOnceAfterBuild() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest,
            forceAndroidLocationManager: true,
            timeLimit: Duration(seconds: 4))
        .then((value) => {loadlocationData(value)})
        .onError((error, stackTrace) => {
              Geolocator.getLastKnownPosition(forceAndroidLocationManager: true)
                  .then((value) => {loadlocationData(value!)})
            });
  }

  loadlocationData(Position value) async {
    var lat = value.latitude;
    var lon = value.longitude;
    log(lat.toString() + 'x' + lon.toString());
    WeatherFactory wf = new WeatherFactory(
        //     'b9b26b0a2dc98163b8412c022f815653'
        '053c90d899896c341a25da81ec9b2eaf',
        language: Language.POLISH);
    Weather w = await wf.currentWeatherByLocation(lat, lon);
    log(w.toJson().toString());

    var keyword = 'geo:$lat;$lon';

    String _endpoint = 'https://api.waqi.info/feed/';
    var key = 'f2a73f1093a122b42ed3b848ea7ffbd988e021ba';
    String url = '$_endpoint/$keyword/?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    AirQuality aq = new AirQuality(jsonBody);

    Get.to(() => MyHomePage(weather: w, air: aq));
  }

// token for air
  // f2a73f1093a122b42ed3b848ea7ffbd988e021ba

  bool permissionDenied() {
    return false;
  }

  @override
  void onClose() async {
    executeOnceAfterBuild();
    super.onClose();
  }
}

class AirQuality {
  bool isGood = true;
  bool isBad = false;
  String quality = '';
  String advice = '';
  int aqi = 0;
  int pm25 = 0;
  int pm10 = 0;
  String station = '';

  AirQuality(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    pm25 = int.tryParse(jsonBody['data']['iaqi']['pm25']['v'].toString()) ?? -1;
    pm10 = int.tryParse(jsonBody['data']['iaqi']['pm10']['v'].toString()) ?? -1;
    station = jsonBody['data']['city']['name'].toString();
    setupLevel(aqi);
  }

  void setupLevel(int aqi) {
    if (aqi <= 100) {
      quality = 'Bardzo dobra';
      advice = 'Skorzystaj z dobrego powietrza i wyjdz na spacer';
    } else if (aqi <= 150) {
      quality = 'Nie za dobra';
      advice = 'Jesli tylko mozesz zostan w domu , zalatwiaj sprawy online';
    } else {
      quality = 'Bardzo zła !';
      advice = ' Zdecydowanie zostan w domu i zalatwiaj sprawy online!';
    }
  }
}
