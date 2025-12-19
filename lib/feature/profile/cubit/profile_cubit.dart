import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  void updateProfile(String newUsername, String newLocation) {
    emit(ProfileUpdated(newUsername, newLocation));
  }
}
