import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final DailyForecast forecast;
  final bool isToday;
  final bool compact;

  const WeatherCard({
    super.key,
    required this.forecast,
    this.isToday = false,
    this.compact = false,
  });

  Color _getBackgroundColor() {
    if (forecast.weatherCode == 0) return Colors.blue.shade300;
    if (forecast.weatherCode <= 3) return Colors.grey.shade400;
    if (forecast.weatherCode <= 67) return Colors.blue.shade600;
    return Colors.grey.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('EEE, MMM d');
    final title = isToday ? 'Today' : dayFormat.format(forecast.date);

    if (!compact) {}

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getBackgroundColor(),
            _getBackgroundColor().withOpacity(0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 95,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              forecast.weatherEmoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forecast.weatherDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    forecast.precipitationSum > 0
                        ? 'Rain: ${forecast.precipitationSum.toStringAsFixed(1)} mm'
                        : 'Rain: 0.0 mm',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${forecast.temperatureMax.round()}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'min ${forecast.temperatureMin.round()}°C',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
