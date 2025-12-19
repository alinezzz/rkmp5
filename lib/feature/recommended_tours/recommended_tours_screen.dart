import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkmp5/feature/recommended_tours/cubit/recommended_tours_cubit.dart';
import 'package:rkmp5/feature/recommended_tours/cubit/recommended_tours_state.dart';

class RecommendedToursScreen extends StatelessWidget {
  const RecommendedToursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedToursCubit, RecommendedToursState>(
      builder: (context, state) {
        if (state is RecommendedToursLocationNotSet) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Местоположение не указано. Укажите местоположение в профиле для персональной подборки конных туров',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          );
        }

        if (state is RecommendedToursLoaded) {
          if (state.recommendedTours.isEmpty) {
            return const Center(
              child: Text(
                'Для вашего местоположения нет рекомендованных туров.',
                style: TextStyle(fontSize: 16.0),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.recommendedTours.length,
            itemBuilder: (context, index) {
              final tour = state.recommendedTours[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.network(
                          tour.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          tour.name,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
