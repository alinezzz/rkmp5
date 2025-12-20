import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/profile/cubit/profile_cubit.dart';
import 'package:rkmp5/feature/reviews/cubit/reviews_cubit.dart';
import 'package:rkmp5/feature/reviews/cubit/reviews_state.dart';
import 'package:rkmp5/feature/reviews/models/review_model.dart';
import 'package:rkmp5/feature/tour_day_details/tour_day_details_model.dart';
import '../models/horse_tour_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourDetailsScreen extends StatelessWidget {
  final TourModel tour;

  const TourDetailsScreen({super.key, required this.tour});

  void _showAddReviewDialog(BuildContext context) {
    final reviewController = TextEditingController();
    final profileCubit = context.read<ProfileCubit>();
    final reviewsCubit = context.read<ReviewsCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Написать отзыв'),
          content: TextField(
            controller: reviewController,
            decoration: const InputDecoration(labelText: 'Ваш отзыв'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (reviewController.text.isNotEmpty) {
                  final review = Review(
                    author: profileCubit.state.username,
                    text: reviewController.text,
                  );
                  reviewsCubit.addReview(review);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Опубликовать'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dayDetails = TourDayDetails(
      dayNumber: 1,
      distance: '20 км',
      altitude: '500 м',
      timeInSaddle: '4 часа',
      stopover: 'Горное озеро',
      requiredSkillLevel: 'Средний',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(tour.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: tour.pictureLink,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 20),
              Text(tour.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(tour.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.push('/tourDayDetails', extra: dayDetails),
                child: const Text('Подробности по дням'),
              ),
              const SizedBox(height: 24),
              const Text('Отзывы', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              BlocBuilder<ReviewsCubit, ReviewsState>(
                builder: (context, state) {
                  if (state.reviews.isEmpty) {
                    return const Center(child: Text('Пока нет ни одного отзыва'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.reviews.length,
                    itemBuilder: (context, index) {
                      final review = state.reviews[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.author,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(review.text),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => context.read<ReviewsCubit>().removeReview(review),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _showAddReviewDialog(context),
                child: const Text('Написать отзыв'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
