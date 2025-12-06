import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/horse_tour_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final List<TourModel> _favorites = [];

  void toggleFavorite(TourModel tour) {
    final currentFavorites = state is FavoritesLoaded ? (state as FavoritesLoaded).favoriteTours : [];
    if (currentFavorites.contains(tour)) {
      final updatedFavorites = List<TourModel>.from(currentFavorites)..remove(tour);
      emit(FavoritesLoaded(updatedFavorites));
    } else {
      final updatedFavorites = List<TourModel>.from(currentFavorites)..add(tour);
      emit(FavoritesLoaded(updatedFavorites));
    }
  }

  bool isFavorite(TourModel tour) {
    return state is FavoritesLoaded && (state as FavoritesLoaded).favoriteTours.contains(tour);
  }
}
