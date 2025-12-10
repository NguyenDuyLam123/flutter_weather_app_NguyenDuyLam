class ForecastModel {
  final DateTime dateTime;
  final double temperature;
  final String icon;

  ForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.parse(json["dt_txt"]),
      temperature: json["main"]["temp"].toDouble(),
      icon: json["weather"][0]["icon"],
    );
  }
}
