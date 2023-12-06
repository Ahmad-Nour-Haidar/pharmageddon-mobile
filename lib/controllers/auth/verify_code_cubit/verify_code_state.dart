
import '../../../core/class/parent_state.dart';

abstract class VerifyCodeState {}

class VerifyCodeInitialState extends VerifyCodeState {}

class VerifyCodeLoadingState extends VerifyCodeState {}

class VerifyCodeSuccessState extends VerifyCodeState {}

class VerifyCodeFailureState extends VerifyCodeState {
  final ParentState state;

  VerifyCodeFailureState(this.state);
}

class VerifyCodeFailureGetState extends VerifyCodeState {
  final ParentState state;

  VerifyCodeFailureGetState(this.state);
}

class VerifyCodeSuccessGetState extends VerifyCodeState {}

class VerifyCodeLoadingGetState extends VerifyCodeState {}
