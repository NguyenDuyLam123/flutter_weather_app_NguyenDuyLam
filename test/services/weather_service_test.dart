import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  group('WeatherService helper tests', () {
    const apiKey = "TESTKEY";
    final service = WeatherService(apiKey: apiKey);

    test('getIconUrl returns proper URL', () {
      final url = service.getIconUrl("04d");

      expect(url, "https://openweathermap.org/img/wn/04d@2x.png");
    });

    test('API key is stored correctly', () {
      expect(service.apiKey, apiKey);
    });
  });
}
