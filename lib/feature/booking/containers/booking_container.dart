import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class BookingContainer extends StatefulWidget {
  final Widget child;

  const BookingContainer({super.key, required this.child});

  static _BookingContainerState of(BuildContext context) {
    final _BookingContainerState? result =
    context.findAncestorStateOfType<_BookingContainerState>();
    assert(result != null, 'BookingsContainer не найден в контексте');
    return result!;
  }

  @override
  _BookingContainerState createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  final List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  void addBooking(BookingModel booking) {
    setState(() {
      _bookings.add(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
