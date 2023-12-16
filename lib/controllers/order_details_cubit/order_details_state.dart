import '../../core/class/parent_state.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsLoadingState extends OrderDetailsState {}

class OrderDetailsSuccessState extends OrderDetailsState {}

class OrderDetailsChangeState extends OrderDetailsState {}

class OrderDetailsFailureState extends OrderDetailsState {
  final ParentState state;

  OrderDetailsFailureState(this.state);
}

// cancel
class OrderDetailsLoadingCancelState extends OrderDetailsState {}

class OrderDetailsSuccessCancelState extends OrderDetailsState {}

// get details
class OrderDetailsGetLoadingState extends OrderDetailsState {}

class OrderDetailsLoadingDeleteMedicineState extends OrderDetailsState {}
class OrderDetailsDeleteMedicineSuccessState extends OrderDetailsState {
  final ParentState state;

  OrderDetailsDeleteMedicineSuccessState(this.state);
}
class OrderDetailsCancelAllState extends OrderDetailsState {}
