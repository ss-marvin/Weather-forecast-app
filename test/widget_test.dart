import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  test('WeatherData parses 7 daily forecasts', () {
    final json = {
      'latitude': 59.3293,
      'longitude': 18.0686,
      'daily': {
        'time': List.generate(
            7, (i) => '2025-01-${(i + 1).toString().padLeft(2, '0')}'),
        'temperature_2m_max': [10, 11, 9, 8, 7, 6, 5],
        'temperature_2m_min': [3, 4, 2, 1, 0, -1, -2],
        'weathercode': [0, 1, 2, 3, 61, 71, 95],
        'precipitation_sum': [0, 0, 0.2, 1.0, 5.0, 0.0, 2.3],
      }
    };

    final data = WeatherData.fromJson(json);

    expect(data.dailyForecasts.length, 7);
    expect(data.dailyForecasts.first.weatherCode, 0);
    expect(data.dailyForecasts.first.temperatureMax, 10);
  });
}
