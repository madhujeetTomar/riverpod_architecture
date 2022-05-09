
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_architecture/api/api.dart';
import 'package:riverpod_architecture/api/api_keys.default.dart';
import 'package:riverpod_architecture/entities/weather/weather.dart';


class WeatherRepository
{
final OpenWeatherMapAPI api;
final http.Client client;

  WeatherRepository(this.api, this.client);


  Future<Weather> getWeather({required String cityName}) =>_getData(
uri: api.weather(cityName),
builder: (data) => Weather.fromJson(data),
);
Future<T> _getData<T>({
  required Uri uri,
  required T Function(dynamic data) builder,
}) async {
  try {
    final response = await client.get(uri);
    switch (response.statusCode) {
      case 200:
        final data = json.decode(response.body);
        return builder(data);

      default:
        throw "null";
    }
  } on Exception catch (_) {
    throw "null";
  }
}
}
/// Providers used by rest of the app
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  /// Use the API key passed via --dart-define,
  /// or fallback to the one defined in api_keys.dart
  // set key to const
return WeatherRepository(
   OpenWeatherMapAPI(APIKeys.openWeatherAPIKey),
    http.Client(),
  );
});
