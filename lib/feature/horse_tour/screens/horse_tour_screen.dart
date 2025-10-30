import 'package:flutter/material.dart';
import '../models/horse_tour_model.dart';
import '../horse_tour_repository.dart';
import 'package:rkmp5/feature/booking/screens/booking_screen.dart';

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
      body: ToursListView(
        tours: tours,
        onBookTap: (tour) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingFormScreen(tour: tour),
            ),
          );
        },
      ),
    );
  }
}

class ToursListView extends StatelessWidget {
  final List<TourModel> tours;
  final Function(TourModel) onBookTap;

  const ToursListView({
    super.key,
    required this.tours,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tours.length,
      itemBuilder: (context, index) {
        final tour = tours[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(tour.name),
            subtitle: Text('${tour.location} - ${tour.duration} - \$${tour.pricePerPerson} за одного человека'),
            trailing: ElevatedButton(
              onPressed: () => onBookTap(tour),
              child: Text('Забронировать'),
            ),
          ),
        );
      },
    );
  }
}
