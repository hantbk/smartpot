// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/sensordets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantapp/pages/PlantIndentifyPage.dart';
import 'package:plantapp/pages/models/Plant.dart';
import 'package:plantapp/pages/micro/SmartPlanting.dart';

class NodeDetails extends StatefulWidget {
  const NodeDetails({super.key});

  @override
  State<NodeDetails> createState() => _NodeDetailsState();
}

class _NodeDetailsState extends State<NodeDetails> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String sensedtemp = "0";
  String sensedhumidity = "0";
  String sensedlight = "0";
  String sensedTankLevel = "0";
  int motor = 0;
  final DatabaseReference _motorRef =
      FirebaseDatabase.instance.ref().child('gardenId1/mayBom');

  motorSwitch(int valueStateOfMayBom) async {
    setState(() {
      motor = valueStateOfMayBom;
      print(motor);
    });
    await _motorRef.set(motor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Smart Planting System",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(161, 207, 107, 1),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
                child: Text(
              "Pot 1 Details",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            )),
            Image.asset("lib/images/cay-kim-tien.jpg"),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(161, 207, 107, 1),
                              Color.fromRGBO(74, 173, 82, 1)
                            ])),
                    child: FutureBuilder(
                        future: _fApp,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Firebase Error! Try again later."),
                            );
                          } else if (snapshot.hasData) {
                            return sensorcontent();
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }))),
            ElevatedButton(
                // TO DO: Add model feature here
                onPressed: () {
                  // runModel(double.parse(sensedtemp),
                  //     double.parse(sensedhumidity), sensedrainfall.toDouble());
                  showInformation(context, 2);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: const Color.fromRGBO(74, 173, 82, 1),
                ),
                child: Text(
                  "Get Plant Information",
                  style: GoogleFonts.poppins(
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.normal, // Different font weight
                    fontSize: 17, // Same font size, or adjust as needed
                  ),
                )),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PlantIdentifyPage(), // Điều hướng đến trang mới
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: const Color.fromRGBO(74, 173, 82, 1),
                ),
                child: Text(
                  "Plant Indentification", // Tiêu đề của nút mới
                  style: GoogleFonts.poppins(
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                )),
            const SizedBox(height: 40),
            SmartPlanting(motorSwitch: motorSwitch, motor: motor),
          ],
        ),
      ),
    );
  }

  Widget sensorcontent() {
    const double tankHeight = 100.0;
    Query _tempRef =
        FirebaseDatabase.instance.ref().child("gardenId1/dhtNhietDo");
    Query _humidityRef =
        FirebaseDatabase.instance.ref().child("gardenId1/dhtDoAm");
    Query _lightRef =
        FirebaseDatabase.instance.ref().child("gardenId1/anhSang");
    Query _tankRef =
        FirebaseDatabase.instance.ref().child("gardenId1/khoangCach");

    // Listen for changes in humidity
    _humidityRef.onValue.listen((event) {
      setState(() {
        final rawData =
            event.snapshot.value.toString(); // Example: "{current: 32.9}"
        final parsedValue = double.tryParse(
            rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "32.9"
        sensedhumidity = parsedValue?.toStringAsFixed(1) ?? ""; // Safely assign
      });
    });

    // Listen for changes in temperature
    _tempRef.onValue.listen((event) {
      setState(() {
        final rawData =
            event.snapshot.value.toString(); // Example: "{current: 29.2}"
        final parsedValue = double.tryParse(
            rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "29.2"
        sensedtemp = parsedValue?.toStringAsFixed(1) ?? ""; // Safely assign
      });
    });

    // Listen for changes in light intensity
    _lightRef.onValue.listen((event) {
      setState(() {
        final rawData =
            event.snapshot.value.toString(); // Example: "{current: 29.2}"
        final parsedValue = double.tryParse(
            rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "29.2"
        sensedlight = parsedValue?.toStringAsFixed(1) ?? ""; // Safely assign
      });
    });

    // Listen for changes in tank level
    _tankRef.onValue.listen((event) {
      setState(() {
        final rawData =
            event.snapshot.value.toString(); // Example: "{current: 50.0}"
        final parsedValue = double.tryParse(
            rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "50.0"
        if (parsedValue != null) {
          sensedTankLevel = ((1 - (parsedValue / tankHeight)) * 100)
              .clamp(0, 100) // Clamp between 0 and 100
              .toStringAsFixed(1); // Format as a percentage
        } else {
          sensedTankLevel = ""; // Handle invalid values
        }
      });
    });

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SensorDetails(
          sensedval: "$sensedtemp°C",
          icon: Icons.thermostat,
          stype: "Temperature",
        ),
        SensorDetails(
          sensedval: "$sensedhumidity%",
          icon: Icons.water,
          stype: "Humidity",
        ),
        SensorDetails(
          sensedval: "$sensedTankLevel%",
          icon: Icons.water_damage,
          stype: "Tank Level",
        ),
        SensorDetails(
          sensedval: "$sensedlight%",
          icon: Icons.lightbulb,
          stype: "Light Intensity",
        ),
      ],
    );
  }
}

// Widget smartPlanting(VoidCallback motorSwitch, int motor, VoidCallback motorSwitch1, int motor1) {
//   return Column(children: [
//     Text(
//       "Smart Watering",
//       style: GoogleFonts.poppins(
//         height: 1,
//         color: Colors.black,
//         fontWeight: FontWeight.w600, // Different font weight
//         fontSize: 20, // Same font size, or adjust as needed
//       ),
//     ),
//     SizedBox(
//       height: 70,
//     ),
//     SizedBox(
//       width: 180,
//       child: CustomSemicircularIndicator(
//         radius: 100,
//         progress: 0.75, // Set the progress value here
//         color: Color.fromRGBO(151, 203, 104, 1),
//         backgroundColor: Color.fromRGBO(0, 100, 53, 1),
//         strokeWidth: 25,
//         child: Column(
//           children: [
//             Text(
//               '${(0.75 * 100).toInt()}%',
//               style: GoogleFonts.poppins(
//                 fontSize: 35,
//                 fontWeight: FontWeight.w800,
//                 color: Color.fromRGBO(0, 100, 53, 1),
//                 height: 0.7,
//               ),
//             ),
//             Text(
//               'Soil Moisture',
//               style: GoogleFonts.poppins(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     ),
//     SizedBox(
//       height: 25,
//     ),
//     GestureDetector(
//       onTap: motorSwitch,
//       child: Container(
//         width: 200,
//         decoration: BoxDecoration(
//           color: motor == 1 ? Colors.red : Color.fromRGBO(203, 203, 203, 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Text(
//               motor == 1 ? "Manual On" : "Manual Off",
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: motor == 1 ? Colors.white : Colors.black,
//                 fontWeight: motor == 1 ? FontWeight.w800 : FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//     SizedBox(height: 25), // Khoảng cách giữa 2 nút
//     GestureDetector(
//       onTap: () {
//         // Không cần setState hoặc hành động gì, chỉ cần UI
//       },
//       child: Container(
//         width: 200,
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(203, 203, 203, 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Text(
//               "Manual Off", // Hoặc "Manual On" tùy theo yêu cầu của bạn
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//     // IrrigationContainer()
//   ]);
// }

void showInformation(BuildContext context, int plantId) {
  // Tìm kiếm cây dựa trên id
  Plant plant = plants.firstWhere((plant) => plant.id == plantId);

  // Hiển thị thông tin cây trong AlertDialog
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
        title: Text(
          'Plant Information',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(plant.imageUrl),
              SizedBox(height: 10),
              Text(
                plant.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                plant.name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              // Lời khuyên chăm sóc cây
              Text(
                "Lời khuyên chăm sóc:",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "Nhiệt độ:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              Text(
                plant.temperatureAdvice,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                "Độ ẩm đất:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              Text(
                plant.soilMoistureAdvice,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                "Chu kỳ tưới cây:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              Text(
                plant.wateringCycleAdvice,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                "Ánh sáng:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              Text(
                plant.lightAdvice,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    },
  );
}
