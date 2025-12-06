import 'package:flutter_bloc/flutter_bloc.dart';
import '../../horse_tour/models/horse_tour_model.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  final List<TourModel> _bookings = [];

  List<TourModel> get bookings => _bookings;

  void addBooking(TourModel tour) {
    emit(BookingLoading());
    _bookings.add(tour);
    emit(BookingLoaded(_bookings));
  }

  void removeBooking(TourModel tour) {
    emit(BookingLoading());
    _bookings.remove(tour);
    emit(BookingLoaded(_bookings));
  }
}


