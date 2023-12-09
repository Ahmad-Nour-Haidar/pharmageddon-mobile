import '../../core/class/parent_state.dart';

abstract class ReportsState {}

class ReportsInitialState extends ReportsState {}

class ReportsLoadingState extends ReportsState {}

class ReportsSuccessState extends ReportsState {}

class ReportsFailureState extends ReportsState {
  final ParentState state;

  ReportsFailureState(this.state);
}

class ReportsChangeState extends ReportsState {}
