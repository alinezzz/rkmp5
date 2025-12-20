import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rkmp5/feature/reviews/cubit/reviews_state.dart';
import 'package:rkmp5/feature/reviews/models/review_model.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(const ReviewsInitial());

  void addReview(Review review) {
    final updatedReviews = List<Review>.from(state.reviews)..add(review);
    emit(ReviewsLoaded(updatedReviews));
  }

  void removeReview(Review review) {
    final updatedReviews = List<Review>.from(state.reviews)..remove(review);
    emit(ReviewsLoaded(updatedReviews));
  }
}
