import 'package:flutter/material.dart';
import 'calculator_screen.dart';

void main() => runApp(const FuelCalculatorApp());

class FuelCalculatorApp extends StatelessWidget {
  const FuelCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Calculator Pro',
      debugShowCheckedModeBanner: false,
      // Налаштування сучасної темної теми
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}