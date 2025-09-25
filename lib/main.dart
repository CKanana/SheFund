import 'package:flutter/material.dart';
import 'package:shefund/home.dart';
import 'login.dart'; // import your login page

void main() {
  runApp(const SheFundApp());
}

class SheFundApp extends StatelessWidget {
  const SheFundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheFund',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 231, 164, 217),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 173, 59, 145),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: SheFundHomePage(), // start with the login page
    );
  }
}
