import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp5/feature/profile/cubit/profile_cubit.dart';
import 'package:rkmp5/feature/profile/cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditProfileDialog(BuildContext context) {
    final usernameController = TextEditingController();
    final profileCubit = context.read<ProfileCubit>();
    usernameController.text = profileCubit.state.username;

    final List<String> locations = ['Не указано', 'лес', 'горы', 'река'];
    String selectedLocation = profileCubit.state.location;

    if (!locations.contains(selectedLocation)) {
      selectedLocation = locations.first;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Редактировать профиль'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Новое имя пользователя'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedLocation,
                    decoration: const InputDecoration(labelText: 'Местоположение'),
                    items: locations.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    profileCubit.updateProfile(
                      usernameController.text,
                      selectedLocation,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Сохранить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://masterpiecer-images.s3.yandex.net/684617e999d311ee85532e0591f1b6d1:upscaled'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.username,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.location,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'admin@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showEditProfileDialog(context),
                child: const Text('Редактировать профиль'),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lime,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => context.pushReplacement('/auth'),
                child: const Text('Выйти'),
              ),
            ],
          ),
        );
      },
    );
  }
}
