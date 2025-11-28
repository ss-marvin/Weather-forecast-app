class WeatherData {
  final double latitude;
  final double longitude;
  final List<DailyForecast> dailyForecasts;
  final DateTime fetchedAt;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.dailyForecasts,
    required this.fetchedAt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    List<DailyForecast> forecasts = [];

    for (int i = 0; i < 7 && i < json['daily']['time'].length; i++) {
      forecasts.add(
        DailyForecast(
          date: DateTime.parse(json['daily']['time'][i]),
          temperatureMax: json['daily']['temperature_2m_max'][i].toDouble(),
          temperatureMin: json['daily']['temperature_2m_min'][i].toDouble(),
          weatherCode: json['daily']['weathercode'][i],
          precipitationSum:
              json['daily']['precipitation_sum'][i]?.toDouble() ?? 0.0,
        ),
      );
    }

    return WeatherData(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      dailyForecasts: forecasts,
      fetchedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'daily': {
        'time': dailyForecasts.map((f) => f.date.toIso8601String()).toList(),
        'temperature_2m_max': dailyForecasts
            .map((f) => f.temperatureMax)
            .toList(),
        'temperature_2m_min': dailyForecasts
            .map((f) => f.temperatureMin)
            .toList(),
        'weathercode': dailyForecasts.map((f) => f.weatherCode).toList(),
        'precipitation_sum': dailyForecasts
            .map((f) => f.precipitationSum)
            .toList(),
      },
      'fetchedAt': fetchedAt.toIso8601String(),
    };
  }
}

class DailyForecast {
  final DateTime date;
  final double temperatureMax;
  final double temperatureMin;
  final int weatherCode;
  final double precipitationSum;

  DailyForecast({
    required this.date,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCode,
    required this.precipitationSum,
  });

  String get weatherDescription {
    if (weatherCode == 0) return 'Clear sky';
    if (weatherCode <= 3) return 'Partly cloudy';
    if (weatherCode <= 67) return 'Rainy';
    if (weatherCode <= 77) return 'Snowy';
    return 'Stormy';
  }

  String get weatherEmoji {
    if (weatherCode == 0) return '☀️';
    if (weatherCode <= 3) return '⛅';
    if (weatherCode <= 67) return '🌧️';
    if (weatherCode <= 77) return '🌨️';
    return '⛈️';
  }
}
