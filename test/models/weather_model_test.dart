import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  group('WeatherModel JSON parsing', () {
    test('WeatherModel parses correctly from JSON', () {
      final json = {
        "weather": [
          {"main": "Clouds", "icon": "04d"},
        ],
        "main": {"temp": 25.5, "humidity": 80, "pressure": 1010},
        "wind": {"speed": 5.2},
        "visibility": 9000,
        "sys": {"country": "VN"},
        "name": "Hanoi",
      };

      final weather = WeatherModel.fromJson(json);

      expect(weather.cityName, "Hanoi");
      expect(weather.country, "VN");
      expect(weather.temperature, 25.5);
      expect(weather.humidity, 80);
      expect(weather.pressure, 1010);
      expect(weather.windSpeed, 5.2);
      expect(weather.visibility, 9000);
      expect(weather.mainCondition, "Clouds");
      expect(weather.icon, "04d");
    });
  });
}
