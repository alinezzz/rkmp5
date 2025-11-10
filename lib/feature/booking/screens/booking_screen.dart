import 'package:flutter/material.dart';
import '../containers/booking_container.dart';
import '../models/booking_model.dart';
import '../../horse_tour/models/horse_tour_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingContainer.of(context).bookings;

    return Scaffold(
      appBar: AppBar(title: const Text('Мои бронирования')),
      body: bookings.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
              'https://masterpiecer-images.s3.yandex.net/c74dc3d877a111eeb11ee6d39d9a42a4:upscaled',
              width: 200,
              height: 200,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            const Text('Пока нет забронированных туров'),
          ],
        ),
      )
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final BookingModel booking = bookings[index];
          final TourModel tour = booking.tour;

          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: tour.pictureLink,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(tour.name),
            subtitle: Text(
              '[С] ${booking.startDate.toIso8601String().split("T")[0]} '
                  '[по] ${booking.endDate.toIso8601String().split("T")[0]}',
            ),
          );
        },
      ),
    );
  }
}

