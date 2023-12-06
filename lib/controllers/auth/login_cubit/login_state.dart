
import '../../../core/class/parent_state.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final ParentState state;

  LoginFailureState(this.state);
}

class LoginNotVerifyState extends LoginState {}

class LoginChangeShowPasswordState extends LoginState {}

class LoginChangeState extends LoginState {}
