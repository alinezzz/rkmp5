import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  void changeUsername(String newUsername) {
    emit(ProfileUpdated(newUsername));
  }
}
