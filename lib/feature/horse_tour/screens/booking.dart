import 'package:flutter/material.dart';
import '../../booking/containers/booking_container.dart';
import '../../booking/models/booking_model.dart';
import '../models/horse_tour_model.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingContainer.of(context).bookings;

    return Scaffold(
      appBar: AppBar(title: const Text('Мои бронирования')),
      body: bookings.isEmpty
          ? const Center(child: Text('Нет оформленных бронирований.'))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final BookingModel booking = bookings[index];
          final TourModel tour = booking.tour;

          return ListTile(
            title: Text(tour.name),
            subtitle: Text(
              'С ${booking.startDate.toIso8601String().split("T")[0]} '
                  'по ${booking.endDate.toIso8601String().split("T")[0]}',
            ),
          );
        },
      ),
    );
  }
}
