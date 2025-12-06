import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  final String username;

  const ProfileState(this.username);

  @override
  List<Object> get props => [username];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super('admin');
}

class ProfileUpdated extends ProfileState {
  const ProfileUpdated(String username) : super(username);
}
