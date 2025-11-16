import 'package:flutter/material.dart';
import 'package:rkmp5/feature/booking/containers/booking_container.dart';
import 'package:rkmp5/feature/profile/profile_screen.dart';
import 'feature/horse_tour/screens/horse_tour_screen.dart';
import 'feature/booking/screens/booking_form_screen.dart';
import 'feature/booking/screens/booking_screen.dart';
import 'feature/horse_tour/models/horse_tour_model.dart';
import 'feature/booking/models/booking_model.dart';
import 'package:rkmp5/share/widgets/favorites_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/horse_tour/auth/auth_screen.dart';
import 'feature/horse_tour/screens/tour_details_screen.dart';

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
      builder: (context, state) => HorseToursListScreen(),
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
        final tour = state.extra is TourModel ? state.extra as TourModel : null;
        return BookingFormScreen(
          tour: tour!,
          onSubmit: (booking) {
            BookingContainer.of(context).addBooking(booking);
            context.go('/bookings');
          },
          onCancel: () {
            context.pop();
          },
        );
      },
    ),
    GoRoute(
      path: '/bookings',
      name: 'bookings',
      builder: (context, state) {
        return const BookingsScreen(bookings: [],);
      },
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) {
        final args = state.extra as FavoritesScreenArgs?;
        return FavoritesScreen(
          favoriteTours: args?.favoriteTours ?? [],
          onRemoveFavorite: args?.onRemoveFavorite ?? (_) {},
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

// Класс для передачи аргументов на экран "Избранное"
class FavoritesScreenArgs {
  final List<TourModel> favoriteTours;
  final Function(TourModel) onRemoveFavorite;

  FavoritesScreenArgs({
    required this.favoriteTours,
    required this.onRemoveFavorite,
  });
}
