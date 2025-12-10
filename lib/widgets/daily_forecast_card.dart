// lib/widgets/daily_forecast_card.dart
import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';

class DailyForecastCard extends StatelessWidget {
  final String dateKey;
  final List<ForecastModel> dayForecasts;
  final WeatherService weatherService;
  const DailyForecastCard({
    Key? key,
    required this.dateKey,
    required this.dayForecasts,
    required this.weatherService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temps = dayForecasts.map((e) => e.temperature).toList();
    final min = temps.reduce((a, b) => a < b ? a : b);
    final max = temps.reduce((a, b) => a > b ? a : b);
    final icon = dayForecasts[dayForecasts.length ~/ 2].icon;
    final parts = dateKey.split('-');
    final dt = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    final label = DateFormat('EEE, MMM d').format(dt);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.network(weatherService.getIconUrl(icon)),
        title: Text(label),
        subtitle: Text('Min ${min.round()}° • Max ${max.round()}°'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
