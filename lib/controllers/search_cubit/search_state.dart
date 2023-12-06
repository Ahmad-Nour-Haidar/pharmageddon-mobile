import '../../core/class/parent_state.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final String value;

  SearchSuccessState(this.value);
}

class SearchNoDataState extends SearchState {
  final String value;

  SearchNoDataState(this.value);
}

class SearchFailureState extends SearchState {
  final ParentState state;

  SearchFailureState(this.state);
}
