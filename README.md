# Weather Forecast App (Flutter)

A simple Flutter weather app that fetches a **7-day forecast** from the Open-Meteo API using **latitude/longitude** input.  
The app follows an **MVVM** structure (Model + ViewModel + View) and includes **offline detection** and **local caching**.

## Features
- Fetch weather forecast by **Latitude / Longitude**
- Shows **7-day forecast** (date, min/max temperature, precipitation)
- Visual representation of the weather using **emoji + color**
- Detects internet connection status (shows an offline banner)
- Saves the latest forecast locally using **SharedPreferences**
- Input validation (only numeric values allowed)

## Tech Stack
- **Flutter / Dart**
- **Open-Meteo API**
- `http` for REST calls
- `provider` for state management (ChangeNotifier)
- `shared_preferences` for persistence
- `connectivity_plus` for online/offline status

## Project Structure (MVVM)
lib/
main.dart
models/
weather_model.dart
services/
weather_service.dart
storage_service.dart
viewmodels/
weather_viewmodel.dart
views/
weather_screen.dart
widgets/
input_section.dart
weather_card.dart


## How It Works (Flow)
1. User enters **latitude** and **longitude**
2. Press **Get Forecast**
3. ViewModel calls the WeatherService (REST API)
4. JSON is parsed into model classes (`WeatherData.fromJson`)
5. Result is saved locally (SharedPreferences)
6. UI updates automatically (Provider + notifyListeners)

If the device is offline:
- The app shows an **offline banner**
- Previously saved forecast can still be displayed (cached data)

## API Used
- **Open-Meteo** forecast endpoint  
The app requests:
- `weathercode`
- `temperature_2m_max`
- `temperature_2m_min`
- `precipitation_sum`
- `forecast_days=7`

