import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherData> fetchWeatherData(
    double latitude,
    double longitude,
  ) async {
    try {
      // Validate coordinates
      if (latitude < -90 || latitude > 90) {
        throw Exception('Latitude must be between -90 and 90');
      }
      if (longitude < -180 || longitude > 180) {
        throw Exception('Longitude must be between -180 and 180');
      }

      final url = Uri.parse(
        '$_baseUrl?latitude=$latitude&longitude=$longitude'
        '&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum'
        '&forecast_days=7'
        '&timezone=auto',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception(
            'Request timeout. Please check your internet connection.',
          );
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return WeatherData.fromJson(jsonData);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchWeatherData: $e');
      rethrow;
    }
  }
}
