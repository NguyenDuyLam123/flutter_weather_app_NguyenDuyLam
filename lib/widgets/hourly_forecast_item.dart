// lib/widgets/hourly_forecast_item.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';

class HourlyForecastItem extends StatelessWidget {
  final ForecastModel forecast;
  final WeatherService weatherService;

  const HourlyForecastItem({
    super.key,
    required this.forecast,
    required this.weatherService,
  });

  @override
  Widget build(BuildContext context) {
    final timeLabel = DateFormat('HH:mm').format(forecast.dateTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(timeLabel, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 6),
        Image.network(
          weatherService.getIconUrl(forecast.icon),
          height: 36,
          width: 36,
        ),
        const SizedBox(height: 6),
        Text(
          '${forecast.temperature.round()}°',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
