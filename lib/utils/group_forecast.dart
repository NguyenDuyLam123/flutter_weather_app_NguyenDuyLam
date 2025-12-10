// lib/utils/group_forecast.dart
import '../models/forecast_model.dart';

/// Group list of forecasts (which usually are 3-hour steps) by date string "YYYY-M-D".
Map<String, List<ForecastModel>> groupForecastByDate(List<ForecastModel> list) {
  final Map<String, List<ForecastModel>> map = {};
  for (final f in list) {
    final d = f.dateTime;
    final key = '${d.year}-${d.month}-${d.day}';
    map.putIfAbsent(key, () => []).add(f);
  }
  return map;
}
