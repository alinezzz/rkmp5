import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://masterpiecer-images.s3.yandex.net/684617e999d311ee85532e0591f1b6d1:upscaled'),
              ),
              SizedBox(height: 20),
              Text(
                'admin',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'admin@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => context.pushReplacement('/auth'),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}
