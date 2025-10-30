import 'package:flutter/material.dart';
import '../../horse_tour/models/horse_tour_model.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Подтверждение бронирования ${widget.tour.name}'),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма бронирования'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${widget.tour.name} (${widget.tour.location}) - \$${widget.tour.pricePerPerson} за одного человека',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,),),
              const SizedBox(height: 16),

              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(
                  labelText: 'Дата начала (ГГГГ-ММ-ДД)',),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите дату начала тура';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'Дата окончания (ГГГГ-ММ-ДД)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите дату окончания тура';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _onConfirmTap,
                child: const Text('Подтверждение бронирования'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
