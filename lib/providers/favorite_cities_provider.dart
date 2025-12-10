// lib/providers/favorite_cities_provider.dart
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class FavoriteCitiesProvider extends ChangeNotifier {
  final StorageService storageService;
  List<String> _favorites = [];

  FavoriteCitiesProvider({required this.storageService}) {
    _load();
  }

  List<String> get favorites => List.unmodifiable(_favorites);

  Future<void> _load() async {
    _favorites = await storageService.getFavoriteCities();
    notifyListeners();
  }

  Future<void> add(String city) async {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      await storageService.saveFavoriteCities(_favorites);
      notifyListeners();
    }
  }

  Future<void> remove(String city) async {
    if (_favorites.remove(city)) {
      await storageService.saveFavoriteCities(_favorites);
      notifyListeners();
    }
  }
}
