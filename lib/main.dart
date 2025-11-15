import 'package:flutter/material.dart';
import 'feature/booking/containers/booking_container.dart';
import 'feature/horse_tour/containers/horse_tour_container.dart';
import 'feature/horse_tour/screens/horse_tour_screen.dart';
import 'package:rkmp5/router.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingContainer(
      child: MaterialApp.router(
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        title: 'Бронирование конных туров',
        theme: ThemeData(primarySwatch: Colors.purple),
      )
    );
  }
}