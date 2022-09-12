import 'package:get/get.dart';
import 'package:training/air_screen.dart';
import 'package:training/permissions_screen.dart';
import 'package:training/splash_screen.dart';
import 'package:training/weather_screen.dart';

import '../my_home_page.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    //Start

    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/home', page: () => MyHomePage()),
    GetPage(name: '/permissions', page: () => PermissionScreen()),
    GetPage(name: '/air', page: () => AirScreen()),
    // GetPage(name: '/weather', page: () => WeatherScreen()),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: Duration(milliseconds: 500),87uy
  ];

  static const LANGUAGES = '/languages';
}
