import '../../core/class/parent_state.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeFailureState extends HomeState {
  final ParentState state;

  HomeFailureState(this.state);
}

class HomeChangeState extends HomeState {}
