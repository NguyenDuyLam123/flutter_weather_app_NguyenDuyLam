// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

import '../widgets/current_weather_card.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_details_section.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // load weather when screen first builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          /// 🔥 Nút mở màn hình Favorite Cities – BỔ SUNG THEO YÊU CẦU
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favorite Cities',
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),

          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.pushNamed(context, '/forecast'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () => provider.refreshWeather(),
        child: Builder(
          builder: (context) {
            /// LOADING STATE
            if (provider.state == WeatherState.loading) {
              return const LoadingShimmer();
            }

            /// ERROR STATE (không có dữ liệu trước đó)
            if (provider.state == WeatherState.error &&
                provider.currentWeather == null) {
              return ErrorWidgetCustom(
                message: provider.errorMessage,
                onRetry: () => provider.fetchWeatherByLocation(),
              );
            }

            /// không có dữ liệu – state fallback
            if (provider.currentWeather == null) {
              return const Center(child: Text('No weather data'));
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (provider.isFromCache)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.orangeAccent,
                    child: const Text(
                      'Hiển thị dữ liệu từ cache (offline)',
                      textAlign: TextAlign.center,
                    ),
                  ),

                /// WEATHER CARD
                CurrentWeatherCard(
                  weather: provider.currentWeather!,
                  weatherService: provider.weatherService,
                ),

                /// HOURLY FORECAST LIST
                HourlyForecastList(
                  forecasts: provider.forecast,
                  weatherService: provider.weatherService,
                ),

                /// DAILY FORECAST (5 ngày)
                ...provider.dailyGrouped.entries
                    .take(5)
                    .map(
                      (e) => DailyForecastCard(
                        dateKey: e.key,
                        dayForecasts: e.value,
                        weatherService: provider.weatherService,
                      ),
                    ),

                /// DETAILS SECTION
                WeatherDetailsSection(weather: provider.currentWeather!),

                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),

      /// SEARCH FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/search');
          if (!mounted) return;

          if (result is String) {
            context.read<WeatherProvider>().fetchWeatherByCity(result);
          }
        },
      ),
    );
  }
}
