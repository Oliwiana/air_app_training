import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/air_screen.dart';
import 'package:training/splash_form_controller.dart';
import 'package:training/weather_screen.dart';
import 'package:weather/weather.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage( { this.weather, this.air});

 final Weather? weather ;
 final AirQuality? air;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _currentIndex = 0;
  var screens;

  @override
  void initState() {
    screens = [AirScreen(air:widget.air),  WeatherScreen(weather: widget.weather )];
    // foo?.length ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: _currentIndex, children: screens),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.masks_outlined), label: 'Powietrze'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wb_cloudy_outlined), label: 'Pogoda'),
        ],
      ),
    );
  }
}
