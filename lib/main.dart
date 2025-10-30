import 'package:flutter/material.dart';
import 'feature/booking/containers/booking_container.dart';
import 'feature/horse_tour/screens/horse_tour_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingContainer(
      child: MaterialApp(
        title: 'Приложение для бронирования конных туров',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ToursListScreen(),
      ),
    );
  }
}
