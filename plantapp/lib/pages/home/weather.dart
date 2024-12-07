import 'package:flutter/material.dart';
import 'package:plantapp/pages/home/weatherdets.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherContainer extends StatefulWidget {
  const WeatherContainer({super.key});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  late final WeatherFactory _wf;
  Weather? _weather; // Class-level variable

  @override
  void initState() {
    super.initState();

    final openWeatherApi = dotenv.env['OPENWEATHER_API'] ?? '';
    _wf = WeatherFactory(openWeatherApi);

    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final weather = await _wf.currentWeatherByCityName("Hanoi");
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 35,
            ),
          ],
        ),
        child: _weather == null
            ? const Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  WeatherDetails(
                      wtype: "Temperature",
                      val:
                          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
                      ic: Icons.thermostat),
                  WeatherDetails(
                      wtype: "Humidity",
                      val: "${_weather?.humidity?.toStringAsFixed(0)}%",
                      ic: Icons.water),
                  const WeatherDetails(
                      wtype: "Rainfall", val: "0mm", ic: Icons.water_drop),
                  WeatherDetails(
                      wtype: "Wind Speed",
                      val: "${_weather?.windSpeed?.toStringAsFixed(0)}mps",
                      ic: Icons.wind_power_rounded),
                ],
              ),
      ),
    );
  }
}
