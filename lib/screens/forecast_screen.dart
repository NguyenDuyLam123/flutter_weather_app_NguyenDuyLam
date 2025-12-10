// lib/screens/forecast_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/hourly_forecast_list.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final grouped = provider.dailyGrouped;
    return Scaffold(
      appBar: AppBar(title: const Text('Forecast')),
      body: provider.state == WeatherState.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.currentWeather == null
          ? const Center(child: Text('No data'))
          : ListView(
              children: [
                // hourly
                HourlyForecastList(
                  forecasts: provider.forecast,
                  weatherService: provider.weatherService,
                ),
                const SizedBox(height: 8),
                // daily grouped
                ...grouped.entries
                    .map(
                      (e) => DailyForecastCard(
                        dateKey: e.key,
                        dayForecasts: e.value,
                        weatherService: provider.weatherService,
                      ),
                    )
                    .toList(),
              ],
            ),
    );
  }
}
