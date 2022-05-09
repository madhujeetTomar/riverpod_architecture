import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_architecture/presentation/city_search_box.dart';
import 'package:riverpod_architecture/presentation/current_weather.dart';

class Weatherpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Spacer(),
              CitySearchBox(),
              Spacer(),
              CurrentWeather(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
