import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/micro/sensordets.dart';
import 'package:firebase_database/firebase_database.dart';

class NodeDetails extends StatefulWidget {
  const NodeDetails({super.key});

  @override
  _NodeDetailsState createState() => _NodeDetailsState();
}

class _NodeDetailsState extends State<NodeDetails> {
  final DatabaseReference _gardenRef = FirebaseDatabase.instance.ref().child('gardenId1');
  Map<String, dynamic>? _gardenData;
  late Stream<DatabaseEvent> _gardenStream;

  @override
  void initState() {
    super.initState();
    _listenToGardenData();
  }

  void _listenToGardenData() {
    // Lắng nghe thay đổi dữ liệu trong thời gian thực
    _gardenStream = _gardenRef.onValue;
    _gardenStream.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          _gardenData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>
          );
        });
      } else {
        print("No garden data found in Firebase");
      }
    });
  }

  @override
  void dispose() {
    // Hủy lắng nghe khi widget bị hủy
    _gardenStream.drain();
    super.dispose();
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
      body: _gardenData == null
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SensorDetails(
                                sensedval: "${_gardenData?['dhtNhietDo']?['current'] ?? 'N/A'}°C",
                                icon: Icons.thermostat,
                                stype: "Temperature",
                              ),
                              SensorDetails(
                                sensedval: "${_gardenData?['dhtDoAm']?['current'] ?? 'N/A'}%",
                                icon: Icons.water_drop,
                                stype: "Humidity",
                              ),
                            ],
                          ),
                          const SizedBox(height: 20), // Add spacing between the rows
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SensorDetails(
                                sensedval: "${_gardenData?['doAmDat']?['current'] ?? 'N/A'}%",
                                icon: Icons.grass,
                                stype: "Soil Moisture",
                              ),
                              SensorDetails(
                                sensedval: "${_gardenData?['anhSang']?['current'] ?? 'N/A'}%",
                                icon: Icons.lightbulb,
                                stype: "Light Intensity",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: const Color.fromRGBO(74, 173, 82, 1),
                    ),
                    child: Text(
                      "Get Watering Recommendation",
                      style: GoogleFonts.poppins(
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    )),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Text(
                      "Irrigation Control",
                      style: GoogleFonts.poppins(
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    // You can add additional widgets for irrigation control here
                  ],
                )
              ],
            ),
    );
  }
}
