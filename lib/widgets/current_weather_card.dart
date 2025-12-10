// lib/widgets/current_weather_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final WeatherService weatherService;

  const CurrentWeatherCard({
    Key? key,
    required this.weather,
    required this.weatherService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMM d').format(DateTime.now());
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
      ),
      child: Column(
        children: [
          Text(
            '${weather.cityName}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(date, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          CachedNetworkImage(
            imageUrl: weatherService.getIconUrl(weather.icon),
            height: 100,
          ),
          const SizedBox(height: 8),
          Text(
            '${weather.temperature.round()}°',
            style: const TextStyle(fontSize: 64, color: Colors.white),
          ),
          Text(
            weather.mainCondition,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
