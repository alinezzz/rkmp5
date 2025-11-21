import 'package:flutter/material.dart';
import 'package:rkmp5/feature/booking/models/booking_model.dart';
import 'package:rkmp5/feature/horse_tour/models/horse_tour_model.dart';

class AppState extends InheritedWidget {
  final List<TourModel> tours;
  final List<TourModel> favorites;
  final List<BookingModel> bookings;
  final Function(TourModel) addFavorite;
  final Function(TourModel) removeFavorite;
  final Function(BookingModel) addBooking;
  final Function(TourModel) removeTour;

  const AppState({
    super.key,
    required super.child,
    required this.tours,
    required this.favorites,
    required this.bookings,
    required this.addFavorite,
    required this.removeFavorite,
    required this.addBooking,
    required this.removeTour,
  });

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return tours != oldWidget.tours ||
        favorites != oldWidget.favorites ||
        bookings != oldWidget.bookings;
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;
  final List<TourModel> tours;

  const AppStateContainer({
    super.key,
    required this.child,
    required this.tours,
  });

  @override
  _AppStateContainerState createState() => _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  late List<TourModel> _tours;
  final List<TourModel> _favorites = [];
  final List<BookingModel> _bookings = [];

  @override
  void initState() {
    super.initState();
    _tours = List.from(widget.tours);
  }

  void _addFavorite(TourModel tour) {
    setState(() {
      if (!_favorites.contains(tour)) {
        _favorites.add(tour);
      }
    });
  }

  void _removeFavorite(TourModel tour) {
    setState(() {
      if (_favorites.contains(tour)) {
        _favorites.remove(tour);
      }
    });
  }

  void _removeTour(TourModel tour) {
    setState(() {
      _tours.remove(tour);
    });
  }

  void _addBooking(BookingModel booking) {
    setState(() {
      _bookings.add(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppState(
      tours: _tours,
      favorites: _favorites,
      bookings: _bookings,
      addFavorite: _addFavorite,
      removeFavorite: _removeFavorite,
      addBooking: _addBooking,
      removeTour: _removeTour,
      child: widget.child,
    );
  }
}
