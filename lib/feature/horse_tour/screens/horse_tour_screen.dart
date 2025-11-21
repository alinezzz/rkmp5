import 'package:flutter/material.dart';
import '../models/horse_tour_model.dart';
import '../horse_tour_repository.dart';
import '../containers/horse_tour_container.dart';
import '../horse_tour_getit.dart';

class HorseToursListScreen extends StatelessWidget {
  final ToursRepository repository = ToursRepository();

  HorseToursListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isRegistered = getit.isRegistered<AppStateGetIt>();
    print("AppStateGetIt зарегистрирован: $isRegistered");
    final appStateGetIt = getit.get<AppStateGetIt>();
    if (appStateGetIt.tours.isEmpty) {
      appStateGetIt.tours = repository.getTours();
    }
    final appState = appStateGetIt.tours;

    return HorseTourContainer(tours: appState);
  }
}
