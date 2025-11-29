import 'package:flutter/material.dart';
import 'package:rkmp5/feature/profile/profile_screen.dart';
import 'feature/horse_tour/screens/horse_tour_screen.dart';
import 'feature/booking/screens/booking_form_screen.dart';
import 'feature/booking/screens/booking_screen.dart';
import 'feature/horse_tour/models/horse_tour_model.dart';
import 'package:rkmp5/feature/horse_tour/screens/favorites_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/horse_tour/auth/auth_screen.dart';
import 'package:rkmp5/feature/horse_tour/screens/tour_details_screen.dart';

final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'toursList',
      builder: (context, state) => const HorseToursListScreen(),
    ),
    GoRoute(
      path: '/tourDetails',
      name: 'tourDetails',
      builder: (context, state) {
        final tour = state.extra as TourModel;
        return TourDetailsScreen(tour: tour);
      },
    ),
    GoRoute(
      path: '/bookingForm',
      name: 'bookingForm',
      builder: (context, state) {
        final tour = state.extra as TourModel;
        return BookingFormScreen(tour: tour);
      },
    ),
    GoRoute(
      path: '/bookings',
      name: 'bookings',
      builder: (context, state) => const BookingsScreen(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) {
        final args = state.extra as FavoritesScreenArgs?;
        return FavoritesScreen(
          favoriteTours: args?.favoriteTours ?? [],
          onRemoveFavorite: args?.onRemoveFavorite ?? (_) {},
          onBook: args?.onBook ?? (_) {},
        );
      },
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);

class FavoritesScreenArgs {
  final List<TourModel> favoriteTours;
  final Function(TourModel) onRemoveFavorite;
  final Function(TourModel) onBook;


  FavoritesScreenArgs({
    required this.favoriteTours,
    required this.onRemoveFavorite,
    required this.onBook,
  });
}
