import '../../core/class/parent_state.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {}

class CartChangeState extends CartState {}

class CartFailureState extends CartState {
  final ParentState state;

  CartFailureState(this.state);
}
