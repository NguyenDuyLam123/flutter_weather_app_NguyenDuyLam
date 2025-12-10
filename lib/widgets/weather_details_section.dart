import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../widgets/weather_detail_item.dart';

class WeatherDetailsSection extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailsSection({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherDetailsItem(
                  label: "Humidity",
                  value: "${weather.humidity}%",
                ),
                WeatherDetailsItem(
                  label: "Pressure",
                  value: "${weather.pressure} hPa",
                ),
                WeatherDetailsItem(
                  label: "Wind",
                  value: "${weather.windSpeed} m/s",
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherDetailsItem(
                  label: "Visibility",
                  value: "${weather.visibility ?? 0} m",
                ),
                WeatherDetailsItem(
                  label: "Condition",
                  value: weather.mainCondition,
                ),
                WeatherDetailsItem(label: "Country", value: weather.country),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
