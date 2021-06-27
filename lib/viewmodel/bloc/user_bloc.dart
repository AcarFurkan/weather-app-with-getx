import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLogin) {
      yield mapLoginEvent();
    } else if (event is UserSignOut) {
      mapSignOutEvent();
    } else if (event is UserCreate) {}

    // TODO: implement mapEventToState
  }

  UserState mapLoginEvent() {
    ///success
    return UserEntered();

    /// unsuccessful
    /// User
  }

  UserState mapSignOutEvent() {
    return UserEntered();
  }

  UserState mapEntered() {
    return UserEntered();
  }
}
