import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_1/model/user.dart';

class WeatherService {
  static const _apiKey = 'd876ced646169f9c0f1c6ed7a921b580';
  static const _baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<WeatherClass> fetchWeather(String cityName) async {
    final url = '$_baseUrl?q=$cityName&appid=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherClass.fromJson(json.decode(response.body));
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }
}