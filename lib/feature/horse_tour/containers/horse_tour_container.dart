import 'package:flutter/material.dart';
import 'package:rkmp5/feature/booking/models/booking_model.dart';
import '../models/horse_tour_model.dart';
import 'package:rkmp5/feature/booking/screens/booking_form_screen.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum AppScreen { toursList, bookingForm, bookings }

class HorseTourContainer extends StatefulWidget {
  final List<TourModel> tours;

  const HorseTourContainer({super.key, required this.tours});

  @override
  _HorseTourContainerState createState() => _HorseTourContainerState();
}

class _HorseTourContainerState extends State<HorseTourContainer> {
  late List<TourModel> _tours;
  final List<TourModel> _favorites = [];
  final List<BookingModel> _bookings = [];

  AppScreen _currentScreen = AppScreen.toursList;
  TourModel? _selectedTour;

  @override
  void initState() {
    super.initState();
    _tours = List.from(widget.tours);
  }

  void _navigateTo(AppScreen screen, {TourModel? tour}) {
    setState(() {
      _currentScreen = screen;
      _selectedTour = tour;
    });
  }

  void _addBooking(BookingModel booking) {
    setState(() {
      _bookings.add(booking);
      _currentScreen = AppScreen.toursList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    const String logoUrl = 'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_689a15b7f9a5050af7f045d0_689a17907a48627e4273bfa9/scale_1200';

    switch (_currentScreen) {
      case AppScreen.toursList:
        body = Column(
          children: [
            CachedNetworkImage(
              imageUrl: logoUrl,
              width: 500,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tours.length,
                itemBuilder: (context, index) {
                  final tour = _tours[index];
                  return TourRow(
                    tour: tour,
                    isFavorite: _favorites.contains(tour),
                    onTap: () => _navigateTo(AppScreen.bookingForm, tour: tour),
                    onFavorite: () {
                      setState(() {
                        if (_favorites.contains(tour)) {
                          _favorites.remove(tour);
                        } else {
                          _favorites.add(tour);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        );
        break;

      case AppScreen.bookingForm:
        body = BookingFormScreen(
          tour: _selectedTour!,
          onSubmit: _addBooking,
          onCancel: () => _navigateTo(AppScreen.toursList),
        );
        break;

      case AppScreen.bookings:
        body = _bookings.isEmpty
            ? const Center(child: Text('Нет бронирований.'))
            : ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            final booking = _bookings[index];
            final tour = booking.tour;
            return ListTile(
              title: Text(tour.name),
              subtitle: Text(
                'С ${booking.startDate.toIso8601String().split("T")[0]} '
                    'по ${booking.endDate.toIso8601String().split("T")[0]}',
              ),
            );
          },
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentScreen == AppScreen.toursList
            ? 'Доступные конные туры'
            : _currentScreen == AppScreen.bookings
            ? 'Мои бронирования'
            : 'Форма бронирования'),
      ),
      body: body,
      floatingActionButton: _currentScreen == AppScreen.toursList
          ? FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('Мои бронирования'),
        onPressed: () => _navigateTo(AppScreen.bookings),
      )
          : null,
    );
  }
}
