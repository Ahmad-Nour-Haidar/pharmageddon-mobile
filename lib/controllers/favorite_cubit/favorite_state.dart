import '../../core/class/parent_state.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final String value;

  FavoriteSuccessState(this.value);
}

class FavoriteFailureState extends FavoriteState {
  final ParentState state;

  FavoriteFailureState(this.state);
}
