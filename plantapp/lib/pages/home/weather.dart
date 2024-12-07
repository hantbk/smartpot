import 'package:flutter/material.dart';
import 'package:plantapp/constants.dart';
import 'package:plantapp/pages/home/weatherdets.dart';
import 'package:weather/weather.dart';

class WeatherContainer extends StatefulWidget {
  const WeatherContainer({super.key});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API);

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Hanoi").then((w) {
      setState(() {
      });
    });
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
            ]),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            WeatherDetails(
                wtype: "Temperature", val: "30°C", ic: Icons.thermostat),
            WeatherDetails(wtype: "Humidity", val: "36%", ic: Icons.water),
            WeatherDetails(
                wtype: "Soil Mosture", val: "30%", ic: Icons.water_drop),
            WeatherDetails(
                wtype: "Light Intensity", val: "30%", ic: Icons.lightbulb)
          ],
          // children: [
          //   WeatherDetails(
          //       wtype: "Temperature",
          //       val: "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
          //       ic: Icons.thermostat),
          //   WeatherDetails(
          //       wtype: "Humidity",
          //       val: "${_weather?.humidity?.toStringAsFixed(0)}%",
          //       ic: Icons.water),
          //   const WeatherDetails(
          //       wtype: "Rainfall", val: "0mm", ic: Icons.water_drop),
          //   WeatherDetails(
          //       wtype: "Wind Speed",
          //       val: "${_weather?.windSpeed?.toStringAsFixed(0)}mps",
          //       ic: Icons.wind_power_rounded)
          // ],
        ),
      ),
    );
  }
}
