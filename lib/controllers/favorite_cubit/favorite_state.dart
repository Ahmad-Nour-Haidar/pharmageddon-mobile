import '../../core/class/parent_state.dart';

abstract class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {}

class FavoriteNoDataState extends FavoriteState {}

class FavoriteFailureState extends FavoriteState {
  final ParentState state;

  FavoriteFailureState(this.state);
}
