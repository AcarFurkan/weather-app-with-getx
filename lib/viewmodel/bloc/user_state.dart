part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserEntered extends UserState {
  @override
  List<Object> get props => [];
}

class UserSignedOut extends UserState {
  @override
  List<Object> get props => [];
}
