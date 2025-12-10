// lib/screens/favorite_cities_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_cities_provider.dart';
import '../providers/weather_provider.dart';

class FavoriteCitiesScreen extends StatelessWidget {
  const FavoriteCitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProv = context.watch<FavoriteCitiesProvider>();
    final weatherProv = context.read<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Cities')),
      body: ListView.separated(
        itemCount: favProv.favorites.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, idx) {
          final city = favProv.favorites[idx];
          return ListTile(
            title: Text(city),
            leading: const Icon(Icons.location_city),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => favProv.remove(city),
            ),
            onTap: () {
              // load weather for selected favorite city
              weatherProv.fetchWeatherByCity(city);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
