import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_obs.dart';
import 'feature/booking/cubit/booking_cubit.dart';
import 'feature/horse_tour/cubit/favorites_cubit.dart';
import 'feature/horse_tour/cubit/auth_cubit.dart';
import 'feature/profile/cubit/profile_cubit.dart';
import 'feature/recommended_tours/cubit/recommended_tours_cubit.dart';
import 'feature/reviews/cubit/reviews_cubit.dart';
import 'package:rkmp5/router.dart';
import 'package:go_router/go_router.dart';
import 'feature/horse_tour/horse_tour_getit.dart';

void main() {
  Bloc.observer = AppBlockObserver();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingCubit()),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(
          create: (context) => RecommendedToursCubit(context.read<ProfileCubit>()),
        ),
        BlocProvider(create: (context) => ReviewsCubit()),
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        title: 'Бронирование конных туров',
        theme: ThemeData(primarySwatch: Colors.purple),
      ),
    );
  }
}
