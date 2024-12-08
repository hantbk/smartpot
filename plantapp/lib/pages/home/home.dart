import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/home/homebuttons.dart';
import 'package:plantapp/pages/macro/MacroDetails.dart';
import 'package:plantapp/pages/micro/MicroDetails.dart';
import 'package:plantapp/pages/home/weather.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final DatabaseReference _gardenRef = FirebaseDatabase.instance.ref().child('gardenId1');
  Map<String, dynamic>? _gardenData;

   @override
  void initState() {
    super.initState();
    _listenToGardenData(); // Start listening to database changes
  }

  void _listenToGardenData() {
    _gardenRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          _gardenData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>,
          );
        });
      } else {
        print("No garden data found in Firebase");
        setState(() {
          _gardenData = null; // Clear the data if the snapshot is empty
        });
      }
    });
  }

  @override
  void dispose() {
    _gardenRef.onDisconnect(); // Stop listening to changes when the widget is disposed
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: ListView(
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Container(
              height: 150,
              width: 500,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(81)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(161, 207, 107, 1),
                        Color.fromRGBO(74, 173, 82, 1)
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Wrap(direction: Axis.vertical, children: [
                Text.rich(TextSpan(
                  text: 'Welcome \n', // First part of the text
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    height: 0.9,
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Username!', // Second part of the text
                      style: GoogleFonts.poppins(
                        height: 0.8,
                        color: Colors.white,
                        fontWeight: FontWeight.w600, // Different font weight
                        fontSize: 35, // Same font size, or adjust as needed
                      ),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                      Text(
                        "Hanoi, Vietnam",
                        style: GoogleFonts.poppins(color: Colors.white),
                      )
                    ],
                  ),
                )
              ]),
            )
          ]),
          const WeatherContainer(),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: Colors.white,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.shade300,
          //             blurRadius: 35,
          //           ),
          //         ]),
          //     child: GridView.count(
          //       crossAxisCount: 2,
          //       childAspectRatio: 2,
          //       shrinkWrap: true,
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //       children: const [
          //         WeatherDetails(
          //             wtype: "Temperature", val: "30°C", ic: Icons.thermostat),
          //         WeatherDetails(
          //             wtype: "Humidity", val: "36%", ic: Icons.water),
          //         WeatherDetails(
          //             wtype: "Soil Mosture", val: "30%", ic: Icons.water_drop),
          //         WeatherDetails(
          //             wtype: "Light Intensity",
          //             val: "30 %",
          //             ic: Icons.lightbulb)
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // Căn trái cho tiêu đề
              children: [
                GestureDetector(
                  onTap: () {
                    // Khi người dùng chạm vào widget, chuyển đến trang MacroPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MacroPage()),
                    );
                  },
                  child: Container(
                    width: double.infinity,  // Chiếm toàn bộ chiều rộng của cha chứa
                    height: 200,  // Chiều cao của bể
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: Offset(0, 2), // Đổ bóng cho phần container
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,  // Căn chỉnh phần nước ở dưới cùng
                      children: [
                        // Thành bể (chiếm toàn bộ chiều rộng của container)
                        Container(
                          width: double.infinity,  // Chiếm toàn bộ chiều rộng của cha
                          height: double.infinity,  // Chiếm toàn bộ chiều cao của cha
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green, width: 3), // Viền xanh lá cây
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // Nước trong bể, chiều cao có thể thay đổi
                        AnimatedContainer(
                          width: double.infinity,  // Chiếm toàn bộ chiều rộng của bể
                          height: _gardenData != null 
                                  ? (200* (_gardenData?['khoangCach']?['current'] / 1000)?? 0).toDouble() 
                                  : 0, // Nếu không có dữ liệu, đặt chiều cao là 0  // Mức nước thay đổi, có thể thay đổi động
                          duration: Duration(seconds: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 110, 169, 218),  // Màu nước xanh biển
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // Thêm phần chia % ở bên phải của bể
                        Positioned(
                          left: 10,
                          top: 10,
                          bottom: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Mức 100%
                              Text(
                                "100%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Mức 50%
                              Text(
                                "50%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Mức 0%
                              Text(
                                "0%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tiêu đề dưới bể nước
                SizedBox(height: 10),  // Khoảng cách giữa bể và tiêu đề
                Center(  // Căn giữa tiêu đề
                  child: Text(
                    "Tank Level",  // Tiêu đề của biểu đồ
                    style: TextStyle(
                      fontSize: 16,  // Kích thước chữ nhỏ hơn
                      fontWeight: FontWeight.normal,  // Giảm độ đậm của chữ
                      color: const Color.fromARGB(255, 0, 0, 0),  // Màu chữ nhạt hơn
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MicroPage()),
                  );
                },
                child: const ButtonsHome(
                  imgpath: "lib/images/iot.jpeg",
                  heading: "In Ground Sensors",
                )),
          ),
        ],
      ),
    );
  }
}