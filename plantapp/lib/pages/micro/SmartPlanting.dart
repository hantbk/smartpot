import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/semicircle_indicator.dart';

class SmartPlanting extends StatefulWidget {
  final Function(int) motorSwitch;
  final int motor;

  const SmartPlanting(
      {super.key, required this.motorSwitch, required this.motor});

  @override
  // ignore: library_private_types_in_public_api
  _SmartPlantingState createState() => _SmartPlantingState();
}

class _SmartPlantingState extends State<SmartPlanting> {
  String sensedsoil = "25";
  final Query _soilRef =
      FirebaseDatabase.instance.ref().child("gardenId1/doAmDat");

  @override
  void initState() {
    super.initState();

    // Listen for changes in soil moisture
    // Listen for changes in soil moisture
    _soilRef.onValue.listen((event) {
      setState(() {
        final rawData =
            event.snapshot.value.toString(); // Example: "{current: 29.2}"
        final parsedValue = double.tryParse(
            rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "29.2
        sensedsoil = parsedValue?.toStringAsFixed(1) ?? ""; // Safely assign
      });
    });
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
        SizedBox(height: 70),
        SizedBox(
          width: 180,
          child: CustomSemicircularIndicator(
            radius: 100,
            progress: (double.tryParse(sensedsoil) ?? 0) /
                100, // Convert to a percentage
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
        GestureDetector(
          onTap: () {
            widget.motorSwitch(widget.motor == 1 ? 0 : 1);  // Truyền giá trị 1 hoặc 0 khi click
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color:
                  widget.motor == 1  ? Colors.red : Color.fromRGBO(203, 203, 203, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.motor == 1 ? "Manual On" : "Manual Off" ,
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
            widget.motorSwitch(widget.motor == 21 ? 20 : 21);  // Truyền giá trị 1 hoặc 0 khi click
          },
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color:
                  widget.motor == 21  ? Color.fromRGBO(74, 173, 82, 1) : Color.fromRGBO(203, 203, 203, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.motor == 21 ? "Auto On" : "Auto Off" ,
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
