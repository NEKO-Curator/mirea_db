import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mirea_db_2/screens/bottom_navigation.dart';
import 'package:mirea_db_2/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Montserrat',
      ),
      title: 'MYONCafe',
      home: FirebaseAuth.instance.currentUser != null
          ? MyHomePage()
          : LoginPage(),
    );
  }
}
