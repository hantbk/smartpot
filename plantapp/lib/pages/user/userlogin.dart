import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/pages/home/home.dart';
import 'package:provider/provider.dart';
import '../../userdets.dart';

class UserLogin extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  // final TextEditingController plantController = TextEditingController();

  UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              Colors.white, // This sets the color of the leading icon to white
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
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(161, 207, 107, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Icon
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                  "lib/images/leaf.png"), // Đảm bảo bạn đã có logo trong thư mục 'assets/images'
            ),
            SizedBox(height: 20), // Add some spacing between logo and the title

            // Title
            Text(
              "Welcome to Smart Garden!",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            SizedBox(
                height: 20), // Add some spacing between the title and fields

            // Username Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(161, 207, 107, 1)),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Location Field
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(161, 207, 107, 1)),
                ),
              ),
            ),
            SizedBox(height: 15),

            // // Plant Field
            // TextField(
            //   controller: plantController,
            //   decoration: InputDecoration(
            //     labelText: 'Plant',
            //     labelStyle: TextStyle(color: Colors.black54),
            //     filled: true,
            //     fillColor: Colors.white,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //       borderSide: BorderSide(color: Colors.grey),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //       borderSide: BorderSide(color: Color.fromRGBO(161, 207, 107, 1)),
            //     ),
            //   ),
            // ),
            SizedBox(height: 30),

            // Next Button
            GestureDetector(
              onTap: () {
                context.read<UserInfo>().setName(nameController.text);
                context.read<UserInfo>().setLocation(locationController.text);
                // context.read<UserInfo>().setPlant(plantController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromRGBO(161, 207, 107, 1),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      "Next",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
