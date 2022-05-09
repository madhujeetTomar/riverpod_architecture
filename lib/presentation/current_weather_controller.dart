import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/weather/weather_data.dart';
import '../repository/weather_repository.dart';
import 'city_search_box.dart';


class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {required this.city})
      : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }
  final WeatherRepository _weatherRepository;
  final String city;

  Future<void> getWeather({required String city}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(cityName: city);
      state = AsyncValue.data(WeatherData.from(weather));
    } on Exception catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return CurrentWeatherController(weatherRepository, city: city);
});
