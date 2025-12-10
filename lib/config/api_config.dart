// lib/config/api_config.dart
class ApiConfig {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  // We'll read the key from dotenv in services, not here directly.
  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';

  static String buildUrl(String endpoint, Map<String, String> params) {
    final uri = Uri.parse('$baseUrl$endpoint');
    final qp = Map<String, String>.from(params);
    // units metric by default
    qp['units'] = qp['units'] ?? 'metric';
    return uri.replace(queryParameters: qp).toString();
  }
}
