import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/booking/models/booking_model.dart';
import 'package:rkmp5/feature/profile/profile_screen.dart';
import '../../../share/widgets/favorites_tour.dart';
import '../models/horse_tour_model.dart';
import 'package:rkmp5/feature/booking/screens/booking_form_screen.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rkmp5/router.dart';

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

  int _currentTab = 0;
  TourModel? _selectedTour;

  @override
  void initState() {
    super.initState();
    _tours = List.from(widget.tours);
  }

  void _showBookingForm(TourModel tour) {
    setState(() {
      _selectedTour = tour;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          BookingFormScreen(
            tour: tour,
            onSubmit: (booking) {
              setState(() {
                _bookings.add(booking);
                _tours.remove(booking.tour);
              });
              context.pop();
              context.push('/bookings', extra: BookingsScreenArgs(bookings: _bookings));
            },
            onCancel: () {
              context.pop();
            },
          ),
    );
  }

  Widget _buildToursList() {
    const String logoUrl =
        'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_689a15b7f9a5050af7f045d0_689a17907a48627e4273bfa9/scale_1200';

    if (_tours.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
              'https://i.pinimg.com/originals/41/f8/65/41f865ca4cfce007720cf280c7410590.jpg',
              width: 300,
              height: 300,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            const Text('Туры пока недоступны.'),
          ],
        ),
      );
    }

    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: logoUrl,
          width: 500,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _tours.length,
            itemBuilder: (context, index) {
              final tour = _tours[index];
              return TourRow(
                tour: tour,
                isFavorite: _favorites.contains(tour),
                onTap: () => context.push('/tourDetails', extra: tour),
                onBook: () => _showBookingForm(tour),
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
  }

  Widget _buildFavorites() {
    return TourFavoritesTable(
      favoriteTours: _favorites,
      onRemoveFavorite: (tour) {
        setState(() {
          _favorites.remove(tour);
        });
      },
      onBook: _showBookingForm,
    );
  }

  Widget _buildBookings() {
    if (_bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
              'https://masterpiecer-images.s3.yandex.net/c74dc3d877a111eeb11ee6d39d9a42a4:upscaled',
              width: 150,
              height: 150,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            const Text('Пока нет бронирований.'),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: _bookings.length,
      itemBuilder: (context, index) {
        final booking = _bookings[index];
        final tour = booking.tour;
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: tour.pictureLink,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(tour.name),
          subtitle: Text(
            'C ${booking.startDate.toIso8601String().split("T")[0]} '
                'по ${booking.endDate.toIso8601String().split("T")[0]}',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(_currentTab == 0
            ? 'Доступные туры'
            : _currentTab == 1
            ? 'Избранные туры'
            : _currentTab == 2
            ? 'Мои бронирования'
            : 'Профиль'),
      ),
      body: IndexedStack(
        index: _currentTab,
        children: [
          _buildToursList(),
          _buildFavorites(),
          _buildBookings(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 0 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                setState(() {_currentTab = 0;});
              },
              child: const Text('Все туры'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 1 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                context.push('/favorites', extra: FavoritesScreenArgs(
                  favoriteTours: _favorites,
                  onRemoveFavorite: (tour) {
                    setState(() {
                      _favorites.remove(tour);
                    });
                  },
                  onBook: _showBookingForm,
                ));
              },
              child: const Text('Избранное'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 2 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                context.push('/bookings', extra: BookingsScreenArgs(bookings: _bookings));
              },
              child: const Text('Мои бронирования'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 3 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                context.push('/profile');
              },
              child: const Text('Профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
