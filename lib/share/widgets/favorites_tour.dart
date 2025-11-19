import 'package:flutter/material.dart';
import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import 'package:rkmp5/feature/booking/screens/booking_form_screen.dart';

import '../../feature/booking/models/booking_model.dart';

class TourFavoritesTable extends StatelessWidget {
  final List<TourModel> favoriteTours;
  final Function(TourModel)? onRemoveFavorite;
  final Function(TourModel)? onBook;

  const TourFavoritesTable({
    super.key,
    required this.favoriteTours,
    this.onRemoveFavorite,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteTours.isEmpty) {
      return const Center(
        child: Text('Избранных туров пока нет'),
      );
    }

    return ListView.builder(
      itemCount: favoriteTours.length,
      itemBuilder: (BuildContext context, int index) {
        final tour = favoriteTours[index];
        return TourRow(
          tour: tour,
          isFavorite: true,
          onFavorite: () {
            if (onRemoveFavorite != null) {
              onRemoveFavorite!(tour);
            }
          },
          onBook: () {
            if (onBook != null) {
              onBook!(tour);
            }
          },
        );
      },
    );
  }
}
