class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String icon;
  final String country;
  final int? visibility;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.icon,
    required this.country,
    this.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": cityName,
    "country": country,
    "main": {"temp": temperature, "humidity": humidity, "pressure": pressure},
    "wind": {"speed": windSpeed},
    "weather": [
      {"main": mainCondition, "icon": icon},
    ],
  };
}
