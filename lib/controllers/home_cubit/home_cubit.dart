import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/enums/screens.dart';
import 'package:pharmageddon_mobile/core/extensions/update_list.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/home_data.dart';
import 'package:pharmageddon_mobile/model/effect_category_model.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../model/medication_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final _homeRemoteData = AppInjection.getIt<HomeRemoteData>();

  final List<MedicationModel> medications = [], discountsData = [];
  final Map<int, MedicationModel> medicationsMap = {};
  final List<ManufacturerModel> manufacturers = [];
  final List<EffectCategoryModel> effectCategories = [];
  var currentScreen = ScreenShow.medications;

  void _update(HomeState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getMedications();
  }

  Future<void> getMedications({bool forceGetData = false}) async {
    if (!(medications.isEmpty || forceGetData)) return;
    _update(HomeGetMedicationsLoadingState());
    final response = await _homeRemoteData.getMedications();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 401) {
        _update(HomeGetFailureState(FailureState()));
      } else {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        medications.clear();
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
        // medications.shuffle();
        _update(HomeGetMedicationsSuccessState());
        medicationsMap.clear();
        for (final m in medications) {
          medicationsMap[m.id ?? 0] = m;
        }
      }
    });
  }

  Future<void> getDiscounts({bool forceGetData = false}) async {
    if (!(discountsData.isEmpty || forceGetData)) return;
    _update(HomeGetDiscountsLoadingState());
    final response = await _homeRemoteData.getDiscount();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 401) {
        _update(HomeGetFailureState(FailureState()));
      } else {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        discountsData.clear();
        discountsData.addAll(temp.map((e) => MedicationModel.fromJson(e)));
        _update(HomeGetDiscountsSuccessState());
      }
    });
  }

  Future<void> getManufacturers({bool forceGetData = false}) async {
    if (!(manufacturers.isEmpty || forceGetData)) return;
    _update(HomeGetManufacturersLoadingState());
    final response = await _homeRemoteData.getManufacturers();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.manufacturers];
      manufacturers.clear();
      manufacturers.addAll(temp.map((e) => ManufacturerModel.fromJson(e)));
      _update(HomeGetManufacturersSuccessState());
    });
  }

  Future<void> getEffectCategories({bool forceGetData = false}) async {
    if (!(effectCategories.isEmpty || forceGetData)) return;
    _update(HomeGetEffectCategoriesLoadingState());
    final response = await _homeRemoteData.getEffectsCategories();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.effect_categories];
      effectCategories.clear();
      effectCategories.addAll(temp.map((e) => EffectCategoryModel.fromJson(e)));
      _update(HomeGetEffectCategoriesSuccessState());
    });
  }

  void changeScreen(ScreenShow s) {
    currentScreen = s;
    _update(HomeChangeState());
    if (currentScreen == ScreenShow.manufacturer) {
      getManufacturers();
    } else if (currentScreen == ScreenShow.medications) {
      getMedications();
    } else if (currentScreen == ScreenShow.effect) {
      getEffectCategories();
    } else {
      getDiscounts();
    }
  }

  Future<List<MedicationModel>> updateQuantityListMedications(List list) async {
    final List<MedicationModel> tempList = [];
    for (final e in list) {
      final id = e[AppRKeys.medicine_id];
      final newQuantity = e[AppRKeys.new_quantity];
      final index = medications.indexWhere((element) => element.id == id);
      if (index == -1) continue;
      final model = medications[index];
      model.availableQuantity = newQuantity;
      medications.update(index, model);
      printme.magenta(medications[index].toJson());
      tempList.add(model);
    }
    _update(HomeChangeState());
    return tempList;
  }
}
