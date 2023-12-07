import '../../core/class/parent_state.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {}

class OrderChangeState extends OrderState {}

class OrderFailureState extends OrderState {
  final ParentState state;

  OrderFailureState(this.state);
}
