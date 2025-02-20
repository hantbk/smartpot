// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/sensordets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantapp/pages/PlantIndentifyPage.dart';
import 'package:plantapp/pages/models/Plant.dart';
import 'package:plantapp/pages/micro/SmartPlanting.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NodeDetails extends StatefulWidget {
  final Plant plant;
  const NodeDetails({super.key, required this.plant});

  @override
  State<NodeDetails> createState() => _NodeDetailsState();
}

class _NodeDetailsState extends State<NodeDetails> {
  late Plant selectedPlant;
  late DatabaseReference _motorRef;

  @override
  void initState() {
    super.initState();
    selectedPlant = widget.plant;
    _motorRef =
        FirebaseDatabase.instance.ref().child('${selectedPlant.potId}/mayBom');
    _setupListeners(); // Call the setupListeners here
  }

  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  String sensedtemp = "0";
  String sensedhumidity = "0";
  String sensedlight = "0";
  String sensedTankLevel = "0";
  String sensedsoil = "0";
  int motor = 0;

  motorSwitch(int valueStateOfMayBom) async {
    setState(() {
      motor = valueStateOfMayBom;
      // print(motor);
    });
    await _motorRef.set(motor);
  }

  void handleSoilMoistureChange(String condition, Color color) {
    setState(() {
      soilMoistureCondition = condition;
      soilMoistureColor = color;
    });
  }

  // Initialize these variables in initState or as class members
  String temperatureCondition = "Loading...";
  String soilMoistureCondition = "Loading...";
  Color temperatureColor = Colors.grey;
  Color soilMoistureColor = Colors.grey;

  void _setupListeners() {
    Query _tempRef = FirebaseDatabase.instance
        .ref()
        .child("${selectedPlant.potId}/dhtNhietDo");

    Query _humidityRef =
        FirebaseDatabase.instance.ref().child("${selectedPlant.potId}/dhtDoAm");

    Query _lightRef =
        FirebaseDatabase.instance.ref().child("${selectedPlant.potId}/anhSang");

    Query _tankRef = FirebaseDatabase.instance
        .ref()
        .child("${selectedPlant.potId}/khoangCach");

    // Listen for changes in humidity
    _humidityRef.onValue.listen((event) {
      setState(() {
        final rawData = event.snapshot.value
            .toString(); // Example: "{current: 32.9, min: 30.0, max: 80.0}"
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

        if (parsedValue != null) {
          if (parsedValue < selectedPlant.minTemp) {
            temperatureCondition = "Temperature too low";
            temperatureColor = Colors.blue;
          } else if (parsedValue > selectedPlant.maxTemp) {
            temperatureCondition = "Temperature too high";
            temperatureColor = Colors.red;
          } else {
            temperatureCondition = "Suitable temperature for growing";
            temperatureColor = Colors.green;
          }
        }
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
      final double tankHeight =
          double.parse(dotenv.env['TANK_HEIGHT'] ?? '19.0');
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
                "Smart Garden",
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
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pot details",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text(
                    selectedPlant.name,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Image.asset(selectedPlant.imageUrl,
                height: 400, width: 250, fit: BoxFit.scaleDown),
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
                  //     double.parse(sensedhumidity), sensedrainfall.toDouble());
                  showInformation(context, selectedPlant.id);
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
            SmartPlanting(
              motorSwitch: motorSwitch,
              motor: motor,
              selectedPlant: selectedPlant,
              onSoilMoistureChange: handleSoilMoistureChange,
            )
          ],
        ),
      ),
    );
  }

  Widget sensorcontent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: temperatureColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  temperatureCondition,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: soilMoistureColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  soilMoistureCondition,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
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
        ),
      ],
    );
  }
}

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
                "Nhiệt độ lý tưởng: ${plant.minTemp} - ${plant.maxTemp}°C.",
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
