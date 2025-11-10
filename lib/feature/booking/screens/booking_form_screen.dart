import 'package:flutter/material.dart';
import '../../horse_tour/models/horse_tour_model.dart';
import '../containers/booking_container.dart';
import '../models/booking_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../horse_tour/models/horse_tour_model.dart';
import '../models/booking_model.dart';

class BookingFormScreen extends StatefulWidget {
  final TourModel tour;
  final void Function(BookingModel) onSubmit;
  final VoidCallback onCancel;

  const BookingFormScreen({
    super.key,
    required this.tour,
    required this.onSubmit,
    required this.onCancel,
  });

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

      widget.onSubmit(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Бронирование сохранено!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: widget.tour.pictureLink,
              height: 200,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text('Забронировать ${widget.tour.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _startDateController,
                    decoration: const InputDecoration(labelText: 'Дата начала (ГГГ-MM-ДД)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Введите дату начала';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _endDateController,
                    decoration: const InputDecoration(labelText: 'Дата окончания (ГГГ-MM-ДД)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Введите дату начала';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _onConfirmTap, child: const Text('Подтвердить бронирование')),
            const SizedBox(height: 12),
            TextButton(onPressed: widget.onCancel, child: const Text('Выход')),
          ],
        ),
      ),
    );
  }
}
