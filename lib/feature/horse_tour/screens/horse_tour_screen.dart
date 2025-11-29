import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/horse_tour_cubit.dart';
import '../cubit/horse_tour_state.dart';
import '../horse_tour_repository.dart';
import '../containers/horse_tour_container.dart';

class HorseToursListScreen extends StatelessWidget {
  const HorseToursListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HorseTourCubit(ToursRepository())..getTours(),
      child: BlocBuilder<HorseTourCubit, HorseTourState>(
        builder: (context, state) {
          if (state is HorseTourLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HorseTourLoaded) {
            return HorseTourContainer(tours: state.tours);
          } else if (state is HorseTourError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Initial state'));
          }
        },
      ),
    );
  }
}
