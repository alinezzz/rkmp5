import 'package:flutter_bloc/flutter_bloc.dart';
import '../horse_tour_repository.dart';
import 'horse_tour_state.dart';

class HorseTourCubit extends Cubit<HorseTourState> {
  final ToursRepository repository;

  HorseTourCubit(this.repository) : super(HorseTourInitial());

  void getTours() async {
    try {
      emit(HorseTourLoading());
      final tours = repository.getTours();
      emit(HorseTourLoaded(tours));
    } catch (e) {
      emit(HorseTourError(e.toString()));
    }
  }
}
