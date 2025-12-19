import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  final String username;
  final String location;

  const ProfileState(this.username, this.location);

  @override
  List<Object> get props => [username, location];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super('admin', 'Не указано');
}

class ProfileUpdated extends ProfileState {
  const ProfileUpdated(String username, String location) : super(username, location);
}
