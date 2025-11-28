import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class StorageService {
  static const String _weatherDataKey = 'cached_weather_data';
  static const String _lastUpdateKey = 'last_update_time';

  Future<void> saveWeatherData(WeatherData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data.toJson());
      await prefs.setString(_weatherDataKey, jsonString);
      await prefs.setString(_lastUpdateKey, DateTime.now().toIso8601String());
    } catch (e) {
      print('Error saving weather data: $e');
      rethrow;
    }
  }

  Future<WeatherData?> loadWeatherData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_weatherDataKey);

      if (jsonString == null) return null;

      final jsonData = jsonDecode(jsonString);
      return WeatherData.fromJson(jsonData);
    } catch (e) {
      print('Error loading weather data: $e');
      return null;
    }
  }

  Future<DateTime?> getLastUpdateTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timeString = prefs.getString(_lastUpdateKey);

      if (timeString == null) return null;

      return DateTime.parse(timeString);
    } catch (e) {
      print('Error getting last update time: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_weatherDataKey);
    await prefs.remove(_lastUpdateKey);
  }
}
