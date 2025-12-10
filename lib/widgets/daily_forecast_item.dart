// lib/widgets/daily_forecast_item.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';

class DailyForecastItem extends StatelessWidget {
  final String dateKey; // e.g. "2025-12-06"
  final List<ForecastModel> dayForecasts;
  final WeatherService weatherService;

  const DailyForecastItem({
    super.key,
    required this.dateKey,
    required this.dayForecasts,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    if (dayForecasts.isEmpty) return const SizedBox.shrink();
    final temps = dayForecasts.map((f) => f.temperature).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b);
    final maxTemp = temps.reduce((a, b) => a > b ? a : b);
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
        leading: Image.network(
          weatherService.getIconUrl(icon),
          width: 48,
          height: 48,
        ),
        title: Text(label),
        subtitle: Text('Min ${minTemp.round()}° • Max ${maxTemp.round()}°'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // optional: open detail for day
        },
      ),
    );
  }
}
