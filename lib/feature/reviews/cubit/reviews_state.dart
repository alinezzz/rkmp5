import 'package:equatable/equatable.dart';
import 'package:rkmp5/feature/reviews/models/review_model.dart';

abstract class ReviewsState extends Equatable {
  final List<Review> reviews;

  const ReviewsState(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial() : super(const []);
}

class ReviewsLoaded extends ReviewsState {
  const ReviewsLoaded(List<Review> reviews) : super(reviews);
}
