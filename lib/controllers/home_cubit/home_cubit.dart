import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys_request.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/home_data.dart';
import 'package:pharmageddon_mobile/model/effect_category_model.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../core/constant/app_strings.dart';
import '../../model/medication_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final homeRemoteData = AppInjection.getIt<HomeRemoteData>();
  late int _initialIndexScreen;
  final List<MedicationModel> medications = [];
  final List<ManufacturerModel> manufacturers = [];
  final List<EffectCategoryModel> effectCategories = [];

  void initial() {
    _initialIndexScreen = 1;
    getMedications();
  }

  Future<void> getMedications({bool forceGetData = false}) async {
    if (!(medications.isEmpty || forceGetData)) {
      emit(HomeGetMedicationsSuccessState());
      return;
    }
    emit(HomeGetMedicationsLoadingState());
    final response = await homeRemoteData.getMedications();
    response.fold((l) {
      emit(HomeGetFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      if (medications.isEmpty) {
        emit(HomeNoDataState());
      } else {
        emit(HomeGetMedicationsSuccessState());
      }
    });
  }

  Future<void> getManufacturers({bool forceGetData = false}) async {
    if (!(manufacturers.isEmpty || forceGetData)) {
      emit(HomeGetFactoriesSuccessState());
      return;
    }
    emit(HomeGetFactoriesLoadingState());
    final response = await homeRemoteData.getManufacturers();
    response.fold((l) {
      emit(HomeGetFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.manufacturers];
      manufacturers.clear();
      manufacturers.addAll(temp.map((e) => ManufacturerModel.fromJson(e)));
      if (manufacturers.isEmpty) {
        emit(HomeNoDataState());
      } else {
        emit(HomeGetFactoriesSuccessState());
      }
    });
  }

  Future<void> getEffectCategories({bool forceGetData = false}) async {
    if (!(effectCategories.isEmpty || forceGetData)) {
      emit(HomeGetEffectCategoriesSuccessState());
      return;
    }
    emit(HomeGetEffectCategoriesLoadingState());
    final response = await homeRemoteData.getEffectsCategories();
    response.fold((l) {
      emit(HomeGetFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.effect_categories];
      effectCategories.clear();
      effectCategories.addAll(temp.map((e) => EffectCategoryModel.fromJson(e)));
      if (effectCategories.isEmpty) {
        emit(HomeNoDataState());
      } else {
        emit(HomeGetEffectCategoriesSuccessState());
      }
    });
  }

  final _titles = [
    AppStrings.manufacturers.tr,
    AppStrings.home.tr,
    AppStrings.pharmacologicalEffect.tr,
  ];

  int get indexScreen => _initialIndexScreen;

  void changeScreen(int index) {
    _initialIndexScreen = index;
    if (index == 0) {
      getManufacturers();
    } else if (index == 1) {
      getMedications();
    } else {
      getEffectCategories();
    }
  }

  String get title => _titles[_initialIndexScreen];
}
