import 'package:flutter/material.dart';
import '../../horse_tour/models/horse_tour_model.dart';
import '../containers/booking_container.dart';
import '../models/booking_model.dart';

class BookingFormScreen extends StatefulWidget {
  final TourModel tour;

  const BookingFormScreen({super.key, required this.tour});

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _onConfirmTap() {
    if (_formKey.currentState!.validate()) {
      final start = DateTime.parse(_startDateController.text);
      final end = DateTime.parse(_endDateController.text);

      final booking = BookingModel(
        tour: widget.tour,
        startDate: start,
        endDate: end,
      );

      BookingContainer.of(context).addBooking(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Бронирование прошло успешно')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бронирование')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Дата начала (ГГГГ-ММ-ДД)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите дату начала тура';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'Дата завершения (ГГГГ-ММ-ДД)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите дату завершения тура';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onConfirmTap, child: const Text('Забронировать')),
            ],
          ),
        ),
      ),
    );
  }
}
