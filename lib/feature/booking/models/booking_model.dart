import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';

class BookingModel {
  final TourModel tour;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel({
    required this.tour,
    required this.startDate,
    required this.endDate,
  });
}
