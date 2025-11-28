import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../services/storage_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  final StorageService _storageService = StorageService();

  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isOnline = true;
  DateTime? _lastUpdateTime;

  WeatherData? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isOnline => _isOnline;
  DateTime? get lastUpdateTime => _lastUpdateTime;

  WeatherViewModel() {
    _initializeConnectivity();
    _loadCachedData();
  }

  Future<void> _initializeConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _isOnline = connectivityResult != ConnectivityResult.none;

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  Future<void> _loadCachedData() async {
    try {
      _weatherData = await _storageService.loadWeatherData();
      _lastUpdateTime = await _storageService.getLastUpdateTime();
      notifyListeners();
    } catch (e) {
      print('Error loading cached data: $e');
    }
  }

  Future<void> fetchWeather(double latitude, double longitude) async {
    // Check internet connection
    if (!_isOnline) {
      _errorMessage = 'No internet connection. Showing cached data.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch data in background
      _weatherData = await _weatherService.fetchWeatherData(
        latitude,
        longitude,
      );

      // Save to cache
      await _storageService.saveWeatherData(_weatherData!);
      _lastUpdateTime = DateTime.now();

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');

      // If fetch fails and we have no cached data, show error
      if (_weatherData == null) {
        _errorMessage = 'Error: $_errorMessage\nNo cached data available.';
      } else {
        _errorMessage = 'Error: $_errorMessage\nShowing cached data.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
