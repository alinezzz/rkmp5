import 'package:equatable/equatable.dart';
import 'package:rkmp5/feature/recommended_tours/tour_data.dart';

abstract class RecommendedToursState extends Equatable {
  const RecommendedToursState();

  @override
  List<Object> get props => [];
}

class RecommendedToursInitial extends RecommendedToursState {}

class RecommendedToursLocationNotSet extends RecommendedToursState {}

class RecommendedToursLoaded extends RecommendedToursState {
  final List<Tour> recommendedTours;

  const RecommendedToursLoaded(this.recommendedTours);

  @override
  List<Object> get props => [recommendedTours];
}
