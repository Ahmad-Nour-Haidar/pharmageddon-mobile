import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../core/constant/app_strings.dart';
import '../../view/widgets/home/effect_category_widget.dart';
import '../../view/widgets/home/manufacturers_widget.dart';
import '../../view/widgets/home/medication_widget.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int _indexScreen = 1;
  final _screens = [
    ManufacturersListWidget(onRefresh: () async {}),
    MedicationsListWidget(onRefresh: () async {}),
    EffectCategoriesListWidget(onRefresh: () async {}),
  ];

  final _titles = [
    AppStrings.manufacturers.tr,
    AppStrings.home.tr,
    AppStrings.pharmacologicalEffect.tr,
  ];

  int get indexScreen => _indexScreen;

  void changeScreen(int index) {
    _indexScreen = index;
    emit(HomeChangeState());
  }

  Widget get screen => _screens[_indexScreen];

  String get title => _titles[_indexScreen];
}
