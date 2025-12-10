// lib/services/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class StorageService {
  static const _weatherKey = 'cached_weather';
  static const _lastUpdateKey = 'last_update';
  static const _favoritesKey = 'favorite_cities';
  static const _unitKey = 'temp_unit';
  static const _windUnitKey = 'wind_unit';
  static const String _hourFormatKey = 'hour_format';

  Future<void> saveWeatherData(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weatherKey, json.encode(weather.toJson()));
    await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<WeatherModel?> getCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_weatherKey);
    if (s == null) return null;
    return WeatherModel.fromJson(json.decode(s));
  }

  Future<bool> isCacheValid() async {
    final prefs = await SharedPreferences.getInstance();
    final t = prefs.getInt(_lastUpdateKey);
    if (t == null) return false;
    final diff = DateTime.now().millisecondsSinceEpoch - t;
    return diff < 30 * 60 * 1000;
  }

  Future<void> saveFavoriteCities(List<String> cities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, cities);
  }

  Future<List<String>> getFavoriteCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> saveTempUnit(String u) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unitKey, u);
  }

  Future<String> getTempUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_unitKey) ?? 'C';
  }

  Future<void> saveWindUnit(String u) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_windUnitKey, u);
  }

  Future<String> getWindUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_windUnitKey) ?? 'm/s';
  }

  Future<void> saveHourFormat(String f) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_hourFormatKey, f);
  }

  Future<String> getHourFormat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_hourFormatKey) ?? '24h';
  }
}
