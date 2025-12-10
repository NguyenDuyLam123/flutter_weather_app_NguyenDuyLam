// lib/widgets/hourly_forecast_list.dart
import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import 'hourly_forecast_item.dart';

class HourlyForecastList extends StatelessWidget {
  final List<ForecastModel> forecasts;
  final WeatherService weatherService;
  final int maxItems; // number of items to show (default ~8 -> 24h)

  const HourlyForecastList({
    super.key,
    required this.forecasts,
    required this.weatherService,
    this.maxItems = 8,
  });

  @override
  Widget build(BuildContext context) {
    final list = forecasts.isEmpty ? [] : forecasts.take(maxItems).toList();
    if (list.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 140,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            child: HourlyForecastItem(
              forecast: list[index],
              weatherService: weatherService,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
