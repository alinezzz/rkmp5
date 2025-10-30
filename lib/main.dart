import 'package:flutter/material.dart';
import 'feature/horse_tour/screens/horse_tour_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение для бронирования конных туров',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ToursListScreen(),
    );
  }
}
