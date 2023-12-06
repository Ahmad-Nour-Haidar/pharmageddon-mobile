import '../../../core/class/parent_state.dart';

abstract class CheckEmailState {}

class CheckEmailInitialState extends CheckEmailState {}

class CheckEmailLoadingState extends CheckEmailState {}

class CheckEmailSuccessState extends CheckEmailState {}

class CheckEmailChangeState extends CheckEmailState {}

class CheckEmailFailureState extends CheckEmailState {
  final ParentState state;

  CheckEmailFailureState(this.state);
}
