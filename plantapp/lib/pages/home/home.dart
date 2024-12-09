// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/home/homebuttons.dart';
import 'package:plantapp/pages/macro/MacroDetails.dart';
import 'package:plantapp/pages/micro/MicroDetails.dart';
import 'package:plantapp/pages/home/weather.dart';
import 'package:plantapp/pages/news/home_news.dart';
import 'package:plantapp/pages/user/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../../userdets.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseReference _gardenRef =
      FirebaseDatabase.instance.ref().child('gardenId1');
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
    _gardenRef
        .onDisconnect(); // Stop listening to changes when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String username = Provider.of<UserInfo>(context, listen: false).name;
    String location = Provider.of<UserInfo>(context, listen: false).location;
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
        actions: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
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
                      text: '$username!', // Second part of the text
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
                        location,
                        style: GoogleFonts.poppins(color: Colors.white),
                      )
                    ],
                  ),
                )
              ]),
            )
          ]),
          const WeatherContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Căn trái cho tiêu đề
              children: [
                GestureDetector(
                  onTap: () {
                    // Khi người dùng chạm vào widget, chuyển đến trang MacroPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MacroPage()),
                    );
                  },
                  child: Container(
                    width: double
                        .infinity, // Chiếm toàn bộ chiều rộng của cha chứa
                    height: 200, // Chiều cao của bể
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
                      alignment: Alignment
                          .bottomCenter, // Căn chỉnh phần nước ở dưới cùng
                      children: [
                        // Thành bể
                        Container(
                          width: double
                              .infinity, // Chiếm toàn bộ chiều rộng của cha
                          height: double
                              .infinity, // Chiếm toàn bộ chiều cao của cha
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.green,
                                width: 3), // Viền xanh lá cây
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        AnimatedContainer(
                          width: double
                              .infinity, // Chiếm toàn bộ chiều rộng của bể
                              height: _gardenData != null
                                  ? (200 * (1 - (_gardenData?['khoangCach']?['current'] ?? 0) / 50)).toDouble().clamp(0.0, double.infinity)
                                  : 0, // Nếu không có dữ liệu, đặt chiều cao là 0
                          duration: Duration(seconds: 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 110, 169, 218), // Màu nước
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // Thêm Text hiển thị % bên cạnh mức nước
                        Positioned(
                          right: 10, // Vị trí Text bên phải bể
                          child: Text(
                            _gardenData != null
                                ? "${((1 - (_gardenData?['khoangCach']?['current'] ?? 0) / 50) * 100).toInt().clamp(0, 100)}%" // Giới hạn phần trăm từ 0 đến 100
                                : "0%", // Nếu không có dữ liệu, hiển thị 0%
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Phần chia % ở bên trái
                        Positioned(
                          left: 10,
                          top: 10,
                          bottom: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "100%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "75%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "50%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "25%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                SizedBox(height: 10), // Khoảng cách giữa bể và tiêu đề
                Center(
                  child: Text(
                    "Tank Level",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 0, 0, 0),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeNewsPage()),
                  );
                },
                child: const ButtonsHome(
                  imgpath: "lib/images/news.jpg",
                  heading: "News",
                )),
          ),
        ],
      ),
    );
  }
}
