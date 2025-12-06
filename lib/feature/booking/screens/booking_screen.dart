import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои бронирования'),
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoaded) {
            final bookings = state.bookings;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text(booking.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<BookingCubit>().removeBooking(booking);
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Нет бронирований'));
          }
        },
      ),
    );
  }
}
