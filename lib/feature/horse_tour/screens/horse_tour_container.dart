import 'package:flutter/material.dart';
import '../models/horse_tour_model.dart';
import '../horse_tour_repository.dart';
import 'package:rkmp5/feature/booking/screens/booking_form_screen.dart';
import 'package:rkmp5/feature/booking/screens/booking_screen.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';

class ToursListScreen extends StatelessWidget {
  final ToursRepository repository = ToursRepository();

  ToursListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tours = repository.getTours();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Доступные конные туры'),
      ),
      body: ToursContainer(
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
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('Мои забронированные туры'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookingScreen(),
            ),
          );
        },
      ),
    );
  }
}

class ToursContainer extends StatefulWidget {
  final List<TourModel> tours;
  final Function(TourModel) onBookTap;

  const ToursContainer({
    super.key,
    required this.tours,
    required this.onBookTap,
  });

  @override
  _ToursContainerState createState() => _ToursContainerState();
}

class _ToursContainerState extends State<ToursContainer> {
  late List<TourModel> _tours;
  final List<TourModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _tours = List.from(widget.tours);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tours.length,
      itemBuilder: (BuildContext context, int index) {
        final tour = _tours[index];
        return TourRow(
          tour: tour,
          isFavorite: _favorites.contains(tour),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingFormScreen(tour: tour),
              ),
            );
          },
          onFavorite: () {
            setState(() {
              if (_favorites.contains(tour)) {
                _favorites.remove(tour);
              } else {
                _favorites.add(tour);
              }
            });
          },
        );
      },
    );
  }
}
