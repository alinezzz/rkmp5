import 'package:equatable/equatable.dart';
import '../models/horse_tour_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<TourModel> favoriteTours;

  const FavoritesLoaded(this.favoriteTours);

  @override
  List<Object> get props => [favoriteTours];
}
