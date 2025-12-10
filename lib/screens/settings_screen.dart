// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final currentTempUnit = provider.tempUnit;
    final currentWindUnit = provider.windUnit;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Temperature unit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Celsius (°C)'),
            value: 'C',
            groupValue: currentTempUnit,
            onChanged: (v) => provider.setTempUnit(v ?? 'C'),
          ),
          RadioListTile<String>(
            title: const Text('Fahrenheit (°F)'),
            value: 'F',
            groupValue: currentTempUnit,
            onChanged: (v) => provider.setTempUnit(v ?? 'F'),
          ),
          const SizedBox(height: 12),
          const Text(
            'Wind unit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('m/s'),
            value: 'm/s',
            groupValue: currentWindUnit,
            onChanged: (v) => provider.setWindUnit(v ?? 'm/s'),
          ),
          RadioListTile<String>(
            title: const Text('km/h'),
            value: 'km/h',
            groupValue: currentWindUnit,
            onChanged: (v) => provider.setWindUnit(v ?? 'km/h'),
          ),
          RadioListTile<String>(
            title: const Text('mph'),
            value: 'mph',
            groupValue: currentWindUnit,
            onChanged: (v) => provider.setWindUnit(v ?? 'mph'),
          ),
          const Text(
            'Time format',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          RadioListTile<String>(
            title: const Text('24-hour format'),
            value: '24h',
            groupValue: provider.hourFormat,
            onChanged: (v) => provider.setHourFormat(v ?? '24h'),
          ),

          RadioListTile<String>(
            title: const Text('12-hour format'),
            value: '12h',
            groupValue: provider.hourFormat,
            onChanged: (v) => provider.setHourFormat(v ?? '12h'),
          ),
        ],
      ),
    );
  }
}
