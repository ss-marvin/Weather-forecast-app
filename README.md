# Weather Forecast App (Flutter)

A simple Flutter weather app that fetches a **7-day forecast** from the Open-Meteo API using **latitude/longitude** input.  
The app follows an **MVVM** structure (Model + ViewModel + View) and includes **offline detection** and **local caching**.

## Features
- 🌍 Fetch weather forecast by **Latitude / Longitude**
- 📅 Shows **7-day forecast** (date, min/max temperature, precipitation)
- 🌤️ Visual representation of the weather using **emoji + color**
- 📶 Detects internet connection status (shows an offline banner)
- 💾 Saves the latest forecast locally using **SharedPreferences**
- ✅ Input validation (only numeric values allowed)

## Tech Stack
- **Flutter / Dart**
- **Open-Meteo API**
- `http` for REST calls
- `provider` for state management (ChangeNotifier)
- `shared_preferences` for persistence
- `connectivity_plus` for online/offline status

## Project Structure (MVVM)
