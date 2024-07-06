import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_1/model/user.dart';
import 'package:weather_app_1/provider/api.dart';

class WeatherProvider with ChangeNotifier {
  WeatherClass? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherClass? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  WeatherProvider() {
    loadWeatherFromSharedPref();
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await WeatherService().fetchWeather(cityName);
      await saveWeatherToSharedPref(_weather!);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadWeatherFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? weatherString = prefs.getString('weather');
    if (weatherString != null) {
      _weather = WeatherClass.fromJson(jsonDecode(weatherString));
      notifyListeners();
    }
  }

  Future<void> saveWeatherToSharedPref(WeatherClass weather) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('weather', jsonEncode(weather.toJson()));
  }
}
