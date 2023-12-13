import '../../core/class/parent_state.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final ParentState state;

  CartSuccessState(ParentState? state) : state = state ?? NoneState();
}

class CartChangeState extends CartState {}

class CartFailureState extends CartState {
  final ParentState state;

  CartFailureState(ParentState? state) : state = state ?? FailureState();
}

class CartInitialDataSuccessState extends CartState {}

class CartInitialDataFailureState extends CartState {
  final ParentState state;

  CartInitialDataFailureState(this.state);
}
