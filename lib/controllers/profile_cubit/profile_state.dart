import '../../core/class/parent_state.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
}

class ProfileFailureState extends ProfileState {
  final ParentState state;

  ProfileFailureState(this.state);
}
