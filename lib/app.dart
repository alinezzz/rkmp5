import 'package:flutter/material.dart';
import 'feature/horse_tour/screens/horse_tour_screen.dart';

class HorseToursApp extends StatelessWidget {
  const HorseToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horse Tours Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToursListScreen(),
    );
  }
}
