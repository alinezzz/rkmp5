import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkmp5/feature/profile/cubit/profile_cubit.dart';
import 'package:rkmp5/feature/profile/cubit/profile_state.dart';
import 'package:rkmp5/feature/recommended_tours/cubit/recommended_tours_state.dart';
import 'package:rkmp5/feature/recommended_tours/tour_data.dart';

class RecommendedToursCubit extends Cubit<RecommendedToursState> {
  late final StreamSubscription _profileSubscription;
  final ProfileCubit _profileCubit;

  RecommendedToursCubit(this._profileCubit) : super(RecommendedToursInitial()) {
    _profileSubscription = _profileCubit.stream.listen((profileState) {
      filterTours(profileState.location);
    });
    filterTours(_profileCubit.state.location);
  }

  void filterTours(String location) {
    if (location == 'Не указано') {
      emit(RecommendedToursLocationNotSet());
    } else {
      final filteredTours =
          allTours.where((tour) => tour.location == location).toList();
      emit(RecommendedToursLoaded(filteredTours));
    }
  }

  @override
  Future<void> close() {
    _profileSubscription.cancel();
    return super.close();
  }
}
