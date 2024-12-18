import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/semicircle_indicator.dart';
import 'package:plantapp/pages/models/Plant.dart';

class SmartPlanting extends StatefulWidget {
  final Function(int) motorSwitch;
  final int motor;
  final Plant selectedPlant;

  const SmartPlanting(
      {super.key,
      required this.motorSwitch,
      required this.motor,
      required this.selectedPlant});

  @override
  _SmartPlantingState createState() => _SmartPlantingState();
}

class _SmartPlantingState extends State<SmartPlanting> {
  String sensedsoil = "25";
  double minHumidity = 0;
  double maxHumidity = 100;

  late DatabaseReference _soilRef;

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
            widget.motorSwitch(widget.motor == 21 ? 20 : 21);
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: widget.motor == 21
                  ? Color.fromRGBO(74, 173, 82, 1)
                  : Color.fromRGBO(203, 203, 203, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.motor == 21 ? "Auto On" : "Auto Off",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: widget.motor == 21 ? Colors.white : Colors.black,
                    fontWeight:
                        widget.motor == 21 ? FontWeight.w800 : FontWeight.w400,
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
