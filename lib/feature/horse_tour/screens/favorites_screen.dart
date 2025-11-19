import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';
import 'package:rkmp5/share/widgets/favorites_tour.dart';

import '../models/horse_tour_model.dart';  // Импорт компонента списка избранных

class FavoritesScreen extends StatelessWidget {
  final List<TourModel> favoriteTours;
  final Function(TourModel) onRemoveFavorite;
  final Function(TourModel) onBook;

  const FavoritesScreen({
    super.key,
    required this.favoriteTours,
    required this.onRemoveFavorite,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранные туры'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: favoriteTours.isEmpty
          ? const Center(
        child: Text('Избранных туров пока нет'),
      )
          : TourFavoritesTable(
        favoriteTours: favoriteTours,
        onRemoveFavorite: (tour) {
          onRemoveFavorite(tour);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Тур ${tour.name} удалён из избранного')),
          );
        },
        onBook: onBook,
      ),
    );
  }
}
