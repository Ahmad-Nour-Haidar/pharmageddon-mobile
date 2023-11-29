import '../../core/class/parent_state.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterChangeShowPasswordState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final ParentState state;

  RegisterFailureState(this.state);
}
