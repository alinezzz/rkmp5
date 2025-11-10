import 'package:flutter/material.dart';
import '../models/horse_tour_model.dart';
import '../horse_tour_repository.dart';
import 'package:rkmp5/feature/booking/screens/booking_form_screen.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import '../containers/horse_tour_container.dart';
import '../horse_tour_repository.dart';

class HorseToursListScreen extends StatelessWidget {
  final ToursRepository repository = ToursRepository();

  HorseToursListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tours = repository.getTours();

    return HorseTourContainer(tours: tours);
  }
}
