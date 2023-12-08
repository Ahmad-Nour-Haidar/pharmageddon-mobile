import '../../core/class/parent_state.dart';

abstract class MedicationDetailsState {}

class MedicationDetailsInitialState extends MedicationDetailsState {}

class MedicationDetailsLoadingState extends MedicationDetailsState {}

class MedicationDetailsChangeState extends MedicationDetailsState {}

class MedicationDetailsSuccessState extends MedicationDetailsState {
  final ParentState state;

  MedicationDetailsSuccessState({ParentState? state})
      : state = state ?? NoneState();
}

class MedicationDetailsFailureState extends MedicationDetailsState {
  final ParentState state;

  MedicationDetailsFailureState(this.state);
}
