import 'package:flutter/material.dart';
import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';

class TourRow extends StatelessWidget {
  final TourModel tour;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavorite;

    TourRow({
    super.key,
    required this.tour,
    this.onTap,
    this.isFavorite = false,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.event),
        title: Text(tour.name),
        subtitle: Text('${tour.location} - ${tour.duration} - \$${tour.pricePerPerson} за одного человека'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onFavorite,
            ),
            ElevatedButton(
              onPressed: onTap,
              child: const Text('Забронировать'),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
