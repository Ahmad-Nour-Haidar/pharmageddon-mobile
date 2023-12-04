import '../../core/class/parent_state.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeNoDataState extends HomeState {}

class HomeGetFailureState extends HomeState {
  final ParentState state;

  HomeGetFailureState(this.state);
}

class HomeGetMedicationsLoadingState extends HomeState {}

class HomeGetMedicationsSuccessState extends HomeState {}

class HomeGetMedicationsFailureState extends HomeState {
  final ParentState state;

  HomeGetMedicationsFailureState(this.state);
}

class HomeGetFactoriesLoadingState extends HomeState {}

class HomeGetFactoriesSuccessState extends HomeState {}

class HomeGetFactoriesFailureState extends HomeState {
  final ParentState state;

  HomeGetFactoriesFailureState(this.state);
}

class HomeGetEffectCategoriesLoadingState extends HomeState {}

class HomeGetEffectCategoriesSuccessState extends HomeState {}

class HomeGetEffectCategoriesFailureState extends HomeState {
  final ParentState state;

  HomeGetEffectCategoriesFailureState(this.state);
}
