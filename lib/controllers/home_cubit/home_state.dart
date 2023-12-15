import '../../core/class/parent_state.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeChangeState extends HomeState {}

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

class HomeGetManufacturersLoadingState extends HomeState {}

class HomeGetManufacturersSuccessState extends HomeState {}

class HomeGetManufacturersFailureState extends HomeState {
  final ParentState state;

  HomeGetManufacturersFailureState(this.state);
}

class HomeGetEffectCategoriesLoadingState extends HomeState {}

class HomeGetEffectCategoriesSuccessState extends HomeState {}

class HomeGetEffectCategoriesFailureState extends HomeState {
  final ParentState state;

  HomeGetEffectCategoriesFailureState(this.state);
}

// discounts

class HomeGetDiscountsLoadingState extends HomeState {}

class HomeGetDiscountsSuccessState extends HomeState {}
