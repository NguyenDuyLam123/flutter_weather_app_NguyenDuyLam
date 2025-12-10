// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/weather_provider.dart';
import 'providers/favorite_cities_provider.dart';

import 'services/weather_service.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';

import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/forecast_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/favorite_cities_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final weatherService = WeatherService(
    apiKey: dotenv.env['OPENWEATHER_API_KEY'] ?? '',
  );

  final locationService = LocationService();
  final storageService = StorageService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              WeatherProvider(weatherService, locationService, storageService),
        ),

        /// Provider cho Favorites (BẮT BUỘC CÓ)
        ChangeNotifierProvider(
          create: (_) => FavoriteCitiesProvider(storageService: storageService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/forecast': (context) => const ForecastScreen(),
        '/settings': (context) => const SettingsScreen(),

        /// route cho Favorite Screen (BẮT BUỘC CÓ)
        '/favorites': (context) => const FavoriteCitiesScreen(),
      },
    );
  }
}
