import 'package:flutter/material.dart';
import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import 'package:rkmp5/feature/booking/screens/booking_screen.dart';

class TourFavoritesTable extends StatelessWidget {
  final List<TourModel> favoriteTours;
  final Function(TourModel)? onRemoveFavorite;

  const TourFavoritesTable({
    super.key,
    required this.favoriteTours,
    this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteTours.isEmpty) {
      return const Center(
        child: Text('No favorite tours yet.'),
      );
    }

    return ListView.builder(
      itemCount: favoriteTours.length,
      itemBuilder: (BuildContext context, int index) {
        final tour = favoriteTours[index];
        return TourRow(
          tour: tour,
          isFavorite: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingFormScreen(tour: tour),
              ),
            );
          },
          onFavorite: () {
            if (onRemoveFavorite != null) {
              onRemoveFavorite!(tour);
            }
          },
        );
      },
    );
  }
}
