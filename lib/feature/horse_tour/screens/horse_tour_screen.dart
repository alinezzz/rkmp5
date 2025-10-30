import 'package:flutter/material.dart';
import '../horse_tour_repository.dart';

class ToursListScreen extends StatelessWidget {
  final ToursRepository repository = ToursRepository();

  ToursListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tours = repository.getTours();

    return Scaffold(
      appBar: AppBar(
        title: Text('Доступные конные туры'),
      ),
      body: ListView.builder(
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return ListTile(
            title: Text(tour.name),
            subtitle: Text('${tour.location} - ${tour.duration} - \$${tour.pricePerPerson} per person'),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
