import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantapp/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: const FirebaseOptions(
          apiKey: "AIzaSyBpnuQTxAQrp4KliZLXfqO9bhlGSoLEmbA",
          authDomain: "iot1-33b58.firebaseapp.com",
          databaseURL:
              "https://iot1-33b58-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "iot1-33b58",
          storageBucket: "iot1-33b58.firebasestorage.app",
          messagingSenderId: "673389701956",
          appId: "1:673389701956:web:ebabe049800319a7350511",
          measurementId: "G-8M54J55R6T"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
