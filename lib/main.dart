import 'package:flutter/material.dart';
import 'package:shefund/budget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Budget Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: false, // optional: enable Material 3 if you want
      ),
      home: const BudgetPage(), // 👈 your budget screen
    );
  }
}
