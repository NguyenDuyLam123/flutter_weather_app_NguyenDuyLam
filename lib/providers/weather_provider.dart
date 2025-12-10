// lib/providers/weather_provider.dart
import 'package:flutter/material.dart';
import 'dart:collection';

import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  // thêm getter public
  WeatherService get weatherService => _weatherService;

  WeatherModel? _currentWeather;
  List<ForecastModel> _forecast = [];
  WeatherState _state = WeatherState.initial;
  String _errorMessage = '';
  bool _isFromCache = false;
  List<String> _favorites = [];
  String _tempUnit = 'C';
  String _windUnit = 'm/s';
  String _hourFormat = '24h';
  String get hourFormat => _hourFormat;

  WeatherProvider(
    this._weatherService,
    this._locationService,
    this._storageService,
  ) {
    _loadPrefs();
  }

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  WeatherState get state => _state;
  String get errorMessage => _errorMessage;
  bool get isFromCache => _isFromCache;
  UnmodifiableListView<String> get favorites =>
      UnmodifiableListView(_favorites);
  String get tempUnit => _tempUnit;
  String get windUnit => _windUnit;

  Future<void> _loadPrefs() async {
    _favorites = await _storageService.getFavoriteCities();
    _tempUnit = await _storageService.getTempUnit();
    _windUnit = await _storageService.getWindUnit();
    _hourFormat = await _storageService.getHourFormat();
    notifyListeners();
  }

  Future<void> addFavorite(String city) async {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      await _storageService.saveFavoriteCities(_favorites);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String city) async {
    _favorites.remove(city);
    await _storageService.saveFavoriteCities(_favorites);
    notifyListeners();
  }

  Future<void> setTempUnit(String u) async {
    _tempUnit = u;
    await _storageService.saveTempUnit(u);
    notifyListeners();
  }

  Future<void> setWindUnit(String u) async {
    _windUnit = u;
    await _storageService.saveWindUnit(u);
    notifyListeners();
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _state = WeatherState.loading;
    _isFromCache = false;
    notifyListeners();
    try {
      _currentWeather = await _weatherService.getCurrentWeatherByCity(cityName);
      _forecast = await _weatherService.getForecast(cityName);
      await _storageService.saveWeatherData(_currentWeather!);
      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
      // try cached
      await loadCachedWeather();
    }
    notifyListeners();
  }

  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    _isFromCache = false;
    notifyListeners();
    try {
      final pos = await _locationService.getCurrentLocation();
      _currentWeather = await _weatherService.getCurrentWeatherByCoordinates(
        pos.latitude,
        pos.longitude,
      );
      final cityName = await _locationService.getCityName(
        pos.latitude,
        pos.longitude,
      );
      _forecast = await _weatherService.getForecast(cityName);
      await _storageService.saveWeatherData(_currentWeather!);
      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
      await loadCachedWeather();
    }
    notifyListeners();
  }

  Future<void> loadCachedWeather() async {
    final cached = await _storageService.getCachedWeather();
    if (cached != null) {
      _currentWeather = cached;
      _state = WeatherState.loaded;
      _isFromCache = true;
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_currentWeather != null) {
      await fetchWeatherByCity(_currentWeather!.cityName);
    } else {
      await fetchWeatherByLocation();
    }
  }

  Future<void> setHourFormat(String f) async {
    _hourFormat = f;
    await _storageService.saveHourFormat(f);
    notifyListeners();
  }

  // Group forecast into days (map dateKey -> list)
  Map<String, List<ForecastModel>> get dailyGrouped {
    final map = <String, List<ForecastModel>>{};
    for (var f in _forecast) {
      final key = '${f.dateTime.year}-${f.dateTime.month}-${f.dateTime.day}';
      map.putIfAbsent(key, () => []).add(f);
    }
    return map;
  }
}
