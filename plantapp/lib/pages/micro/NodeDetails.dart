import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/sensordets.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:firebase_database/firebase_database.dart';

class NodeDetails extends StatefulWidget {
  const NodeDetails({super.key});

  @override
  State<NodeDetails> createState() => _NodeDetailsState();
}

class _NodeDetailsState extends State<NodeDetails> {
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  List result = [];
  String sensedtemp = "35";
  String sensedhumidity = "60";
  String sensedsoil = "25";
  String sensedlight = "100";
  String sensedTankLevel = "50";
  int stateMaybom = 0;

  String predicted = "";
  final List<String> labels = [
    'rice',
    'maize',
    'chickpea',
    'kidneybeans',
    'pigeonpeas',
    'mothbeans',
    'mungbean',
    'blackgram',
    'lentil',
    'pomegranate',
    'banana',
    'mango',
    'grapes',
    'watermelon',
    'muskmelon',
    'apple',
    'orange',
    'papaya',
    'coconut',
    'cotton',
    'jute',
    'coffee'
  ];

  // runModel(temp, humd, rain) async {
  //   final interpreter = await tfl.Interpreter.fromAsset(
  //       'lib/mlmodel/linearRegrssionModel.tflite');
  //   //prepare input as required by your model
  //   //in my case it required a single number and i am requiring it from user
  //   //passing user entered number to model as input
  //   final input = [
  //     [temp, humd, rain]
  //   ];
  //   //Prepare output set and use reshape method from the plugin.
  //   //Input and output preparing guide comes with the model documentation.
  //   var output = List.filled(22, 0).reshape([1, 22]);
  //   //run the interpreter on prepared input and output.
  //   interpreter.run(input, output);
  //   //model process the input and updates the output
  //   //Result variable to show output to user
  //   result = output[0];
  //   print(result);

  //   int maxIndex = 0;
  //   double maxValue = result[0];
  //   for (int i = 1; i < result.length; i++) {
  //     if (result[i] > maxValue) {
  //       maxIndex = i;
  //       maxValue = result[i];
  //     }
  //   }

  //   setState(() {
  //     predicted = labels[maxIndex];
  //     print(predicted);
  //   });
  // }

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
            const SizedBox(
              height: 30,
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
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  backgroundColor: const Color.fromRGBO(74, 173, 82, 1),
                ),
                child: Text(
                  "Get Plant Recommendation",
                  style: GoogleFonts.poppins(
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.normal, // Different font weight
                    fontSize: 17, // Same font size, or adjust as needed
                  ),
                )),
            const SizedBox(height: 30),
            Column(
              children: [
                Text(
                  "Watering Control",
                  style: GoogleFonts.poppins(
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.w600, // Different font weight
                    fontSize: 20, // Same font size, or adjust as needed
                  ),
                ),

                // IrrigationContainer()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sensorcontent() {
    Query _tempRef =
        FirebaseDatabase.instance.ref().child("gardenId1/dhtNhietDo");
    Query _humidityRef =
        FirebaseDatabase.instance.ref().child("gardenId1/dhtDoAm");
    Query _soilRef = FirebaseDatabase.instance.ref().child("gardenId1/doAmDat");
    Query _lightRef =
        FirebaseDatabase.instance.ref().child("gardenId1/anhSang");
    Query _tankRef =
        FirebaseDatabase.instance.ref().child("gardenId1/khoangCach");
    Query _stateMaybomRef =
        FirebaseDatabase.instance.ref().child("gardenId1/mayBom");

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

    // // Listen for changes in tank level
    // _tankRef.onValue.listen((event) {
    //   setState(() {
    //     final rawData =
    //         event.snapshot.value.toString(); // Example: "{current: 29.2}"
    //     final parsedValue = double.tryParse(
    //         rawData.replaceAll(RegExp(r'[^\d.]'), '')); // Extracts: "29.2"
    //     sensedTankLevel =
    //         parsedValue?.toStringAsFixed(1) ?? ""; // Safely assign
    //   });
    // });

    // // Listen for changes in pump state
    // _stateMaybomRef.onValue.listen((event) {
    //   setState(() {
    //     final rawData = event.snapshot.value.toString();
    //     stateMaybom = int.tryParse(rawData) ?? 0;
    //   });
    // });

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
          sensedval: "$sensedsoil°C",
          icon: Icons.water_drop,
          stype: "Soil Moisture",
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
