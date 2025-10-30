import 'package:flutter/material.dart';
import 'feature/horse_tour/containers/horse_tour_container.dart';

class HorseToursApp extends StatelessWidget {
  const HorseToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Приложение для бронирования конных туров',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToursListScreen(),
    );
  }
}
