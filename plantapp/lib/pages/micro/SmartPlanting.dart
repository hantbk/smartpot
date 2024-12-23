import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/semicircle_indicator.dart';
import 'package:plantapp/pages/models/Plant.dart';
import 'package:plantapp/services/notification_service.dart';

class SmartPlanting extends StatefulWidget {
  final Function(int) motorSwitch;
  final int motor;
  final Plant selectedPlant;

  // Thêm các callback để lắng nghe thay đổi
  final Function(String, Color) onSoilMoistureChange;

  const SmartPlanting({
    super.key,
    required this.motorSwitch,
    required this.motor,
    required this.selectedPlant,
    required this.onSoilMoistureChange,
  });

  @override
  _SmartPlantingState createState() => _SmartPlantingState();
}

class _SmartPlantingState extends State<SmartPlanting> {
  String sensedsoil = "25";
  double minHumidity = 0;
  double maxHumidity = 100;
  String soilMoistureCondition = "Loading...";
  Color soilMoistureColor = Colors.grey;

  late DatabaseReference _soilRef;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    _soilRef = FirebaseDatabase.instance
        .ref()
        .child("${widget.selectedPlant.potId}/doAmDat");

    // Listen for changes in soil moisture
    _soilRef.onValue.listen((event) {
      setState(() {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        final current = data?['current'] as num?;
        final min = data?['min'] as num?;
        final max = data?['max'] as num?;
        sensedsoil = current?.toStringAsFixed(1) ?? "";
        minHumidity = min?.toDouble() ?? 0;
        maxHumidity = max?.toDouble() ?? 100;

        // Gọi callback khi giá trị thay đổi
        if (current != null) {
          if (current < minHumidity) {
            soilMoistureCondition = "Soil Moisture too low";
            soilMoistureColor = Colors.red;
          } else if (current > maxHumidity) {
            soilMoistureCondition = "Soil Moisture too high";
            soilMoistureColor = Colors.blue;
          } else {
            soilMoistureCondition = "Soil Moisture suitable for plant";
            soilMoistureColor = Colors.green;
          }

          widget.onSoilMoistureChange(soilMoistureCondition, soilMoistureColor);
        }
        if (current != null) {
          if (current < minHumidity || current > maxHumidity) {
            if (widget.motor == 0 || widget.motor == 1) {
              _notificationService.showNotification(
                "Manual Mode Alert",
                "Soil moisture is outside the range. Please adjust the pump manually.",
              );
            } else if (widget.motor == 21 || widget.motor == 20) {
              _notificationService.showNotification(
                "Auto Mode Alert",
                "Soil moisture is outside the range. The motor has been activated automatically.",
              );
            }
          }
        }
      });
    });
  }

  void _updateMinHumidity(double value) {
    setState(() {
      minHumidity = value;
    });
    _soilRef.update({'min': value}); // Cập nhật giá trị min trên Firebase
  }

  void _updateMaxHumidity(double value) {
    setState(() {
      maxHumidity = value;
    });
    _soilRef.update({'max': value}); // Cập nhật giá trị max trên Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Smart Watering",
          style: GoogleFonts.poppins(
            height: 1,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 80),
        SizedBox(
          width: 180,
          child: CustomSemicircularIndicator(
            radius: 100,
            progress: (double.tryParse(sensedsoil) ?? 0) / 100,
            color: Color.fromRGBO(151, 203, 104, 1),
            backgroundColor: Color.fromRGBO(0, 100, 53, 1),
            strokeWidth: 25,
            child: Column(
              children: [
                Text(
                  '$sensedsoil%',
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(0, 100, 53, 1),
                    height: 0.7,
                  ),
                ),
                Text(
                  'Soil Moisture',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 25),
        // Slider điều chỉnh Min Humidity
        Column(
          children: [
            Text(
              "Min Humidity: ${minHumidity.toStringAsFixed(1)}%",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Slider(
              value: minHumidity,
              min: 0,
              max: 100,
              divisions: 100,
              label: minHumidity.toStringAsFixed(1),
              onChanged: _updateMinHumidity,
            ),
          ],
        ),
        // Slider điều chỉnh Max Humidity
        Column(
          children: [
            Text(
              "Max Humidity: ${maxHumidity.toStringAsFixed(1)}%",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Slider(
              value: maxHumidity,
              min: 0,
              max: 100,
              divisions: 100,
              label: maxHumidity.toStringAsFixed(1),
              onChanged: _updateMaxHumidity,
            ),
          ],
        ),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            widget.motorSwitch(widget.motor == 1 ? 0 : 1);
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: widget.motor == 1
                  ? Colors.red
                  : Color.fromRGBO(203, 203, 203, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.motor == 1 ? "Manual On" : "Manual Off",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: widget.motor == 1 ? Colors.white : Colors.black,
                    fontWeight:
                        widget.motor == 1 ? FontWeight.w800 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            widget.motorSwitch(
                (widget.motor == 20 || widget.motor == 21) ? 0 : 20);
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: (widget.motor == 20 || widget.motor == 21)
                  ? Color.fromRGBO(74, 173, 82, 1)
                  : Color.fromRGBO(203, 203, 203, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  (widget.motor == 20 || widget.motor == 21)
                      ? "Auto On"
                      : "Auto Off",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: (widget.motor == 20 || widget.motor == 21)
                        ? Colors.white
                        : Colors.black,
                    fontWeight: (widget.motor == 20 || widget.motor == 21)
                        ? FontWeight.w800
                        : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }
}
