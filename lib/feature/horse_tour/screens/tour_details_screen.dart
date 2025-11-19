import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/horse_tour_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TourDetailsScreen extends StatelessWidget {
  final TourModel tour;

  const TourDetailsScreen({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tour.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: tour.pictureLink,
              height: 250,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 20),
            Text(tour.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(tour.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
