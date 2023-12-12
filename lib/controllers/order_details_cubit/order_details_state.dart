import '../../core/class/parent_state.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsSuccessState extends OrderDetailsState {}

class OrderDetailsFailureState extends OrderDetailsState {
  final ParentState state;

  OrderDetailsFailureState(this.state);
}

// cancel
class OrderDetailsLoadingCancelState extends OrderDetailsState {}

class OrderDetailsSuccessCancelState extends OrderDetailsState {}
