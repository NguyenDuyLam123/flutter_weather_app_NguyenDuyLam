import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherService {
  final String apiKey;
  WeatherService({required this.apiKey});

  String getIconUrl(String icon) =>
      "https://openweathermap.org/img/wn/$icon@2x.png";

  Future<WeatherModel> getCurrentWeatherByCity(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );
    final res = await http.get(url);
    return WeatherModel.fromJson(jsonDecode(res.body));
  }

  Future<WeatherModel> getCurrentWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
    );
    final res = await http.get(url);
    return WeatherModel.fromJson(jsonDecode(res.body));
  }

  Future<List<ForecastModel>> getForecast(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric",
    );
    final res = await http.get(url);
    final data = jsonDecode(res.body);
    return (data["list"] as List)
        .map((e) => ForecastModel.fromJson(e))
        .toList();
  }
}
