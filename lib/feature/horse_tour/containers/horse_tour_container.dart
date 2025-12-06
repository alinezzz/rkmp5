import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/booking/cubit/booking_cubit.dart';
import 'package:rkmp5/feature/booking/cubit/booking_state.dart';
import 'package:rkmp5/feature/horse_tour/cubit/favorites_cubit.dart';
import 'package:rkmp5/feature/horse_tour/cubit/favorites_state.dart';
import 'package:rkmp5/feature/profile/profile_screen.dart';
import '../../../share/widgets/favorites_tour.dart';
import '../models/horse_tour_model.dart';
import 'package:rkmp5/share/widgets/tour_row.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HorseTourContainer extends StatefulWidget {
  final List<TourModel> tours;

  const HorseTourContainer({super.key, required this.tours});

  @override
  _HorseTourContainerState createState() => _HorseTourContainerState();
}

class _HorseTourContainerState extends State<HorseTourContainer> {
  int _currentTab = 0;

  Widget _buildToursList(BuildContext context) {
    const String logoUrl =
        'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_689a15b7f9a5050af7f045d0_689a17907a48627e4273bfa9/scale_1200';

    if (widget.tours.isEmpty) {
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
            itemCount: widget.tours.length,
            itemBuilder: (context, index) {
              final tour = widget.tours[index];
              return BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favoritesState) {
                  final isFavorite = favoritesState is FavoritesLoaded && favoritesState.favoriteTours.contains(tour);
                  return TourRow(
                    tour: tour,
                    isFavorite: isFavorite,
                    onTap: () => context.push('/tourDetails', extra: tour),
                    onBook: () => context.push('/bookingForm', extra: tour),
                    onFavorite: () =>
                        context.read<FavoritesCubit>().toggleFavorite(tour),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavorites(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final favoriteTours = state is FavoritesLoaded ? state.favoriteTours : <TourModel>[];
        return TourFavoritesTable(
          favoriteTours: favoriteTours,
          onRemoveFavorite: (tour) =>
              context.read<FavoritesCubit>().toggleFavorite(tour),
          onBook: (tour) => context.push('/bookingForm', extra: tour),
        );
      },
    );
  }

  Widget _buildBookings() {
    return BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoaded && state.bookings.isNotEmpty) {
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final tour = state.bookings[index];
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<BookingCubit>().removeBooking(tour);
                    },
                  ),
                );
              },
            );
          }
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
          _buildToursList(context),
          _buildFavorites(context),
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
                 setState(() {_currentTab = 1;});
              },
              child: const Text('Избранное'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 2 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                setState(() {_currentTab = 2;});
              },
              child: const Text('Мои бронирования'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                _currentTab == 3 ? Colors.white : Colors.lime,
              ),
              onPressed: () {
                setState(() {_currentTab = 3;});
              },
              child: const Text('Профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
