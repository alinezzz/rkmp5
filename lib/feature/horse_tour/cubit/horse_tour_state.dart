import 'package:equatable/equatable.dart';
import '../models/horse_tour_model.dart';

abstract class HorseTourState extends Equatable {
  const HorseTourState();

  @override
  List<Object> get props => [];
}

class HorseTourInitial extends HorseTourState {}

class HorseTourLoading extends HorseTourState {}

class HorseTourLoaded extends HorseTourState {
  final List<TourModel> tours;

  const HorseTourLoaded(this.tours);

  @override
  List<Object> get props => [tours];
}

class HorseTourError extends HorseTourState {
  final String message;

  const HorseTourError(this.message);

  @override
  List<Object> get props => [message];
}
