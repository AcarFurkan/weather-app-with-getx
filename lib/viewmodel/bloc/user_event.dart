part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLogin extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserSignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserCreate extends UserEvent {
  @override
  List<Object> get props => [];
}
