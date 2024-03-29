import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/enums/screens.dart';
import 'package:pharmageddon_mobile/core/extensions/update_list.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/home_data.dart';
import 'package:pharmageddon_mobile/model/effect_category_model.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';

import '../../model/medication_model.dart';
import '../../model/medicines_quantity_not_available_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final _homeRemoteData = AppInjection.getIt<HomeRemoteData>();

  final List<MedicationModel> medications = [], discountsData = [];
  final Map<int?, MedicationModel> medicationsMap = {};
  final List<ManufacturerModel> manufacturers = [];
  final List<EffectCategoryModel> effectCategories = [];
  var currentScreen = ScreenShow.medications;
  bool showState = true;

  void _update(HomeState state) {
    if (isClosed) return;
    if (showState == false && state is HomeGetFailureState) return;
    emit(state);
  }

  void initial() {
    getMedications(showState: true);
  }

  Future<void> getMedications({
    bool forceGetData = false,
    bool showState = true,
  }) async {
    if (!(medications.isEmpty || forceGetData)) return;
    this.showState = showState;
    _update(HomeGetMedicationsLoadingState());
    final response = await _homeRemoteData.getMedications();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        medications.clear();
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
        _update(HomeGetMedicationsSuccessState());
        medicationsMap.clear();
        for (final m in medications) {
          medicationsMap[m.id] = m;
        }
      } else {
        _update(HomeChangeState());
      }
    });
    this.showState = true;
  }

  Future<void> getDiscounts({bool forceGetData = false}) async {
    if (!(discountsData.isEmpty || forceGetData)) return;
    _update(HomeGetDiscountsLoadingState());
    final response = await _homeRemoteData.getDiscount();
    response.fold((l) {
      _update(HomeGetFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        discountsData.clear();
        discountsData.addAll(temp.map((e) => MedicationModel.fromJson(e)));
        _update(HomeGetDiscountsSuccessState());
      } else {
        _update(HomeChangeState());
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
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.manufacturers];
        manufacturers.clear();
        manufacturers.addAll(temp.map((e) => ManufacturerModel.fromJson(e)));
      }
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
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.effect_categories];
        effectCategories.clear();
        effectCategories
            .addAll(temp.map((e) => EffectCategoryModel.fromJson(e)));
      }
      _update(HomeGetEffectCategoriesSuccessState());
    });
  }

  void changeScreen(ScreenShow s) {
    currentScreen = s;
    _update(HomeChangeState());
    if (currentScreen == ScreenShow.manufacturer) {
      getManufacturers();
    } else if (currentScreen == ScreenShow.medications) {
      getMedications(showState: true);
    } else if (currentScreen == ScreenShow.effect) {
      getEffectCategories();
    } else {
      getDiscounts();
    }
  }

  void updateQuantityListMedications(
      List<MedicinesQuantityNotAvailableModel> data) {
    for (final e in data) {
      final id = e.medicineId;
      final newQuantity = e.newQuantity;
      final index = medications.indexWhere((element) => element.id == id);
      if (index == -1) continue;
      final model = medications[index];
      model.availableQuantity = newQuantity;
      medications.update(index, model);
      medicationsMap[model.id] = model;
    }
    _update(HomeChangeState());
  }

  void updateMedicationModel(MedicationModel model) {
    final index = medications.indexWhere((element) => element.id == model.id);
    if (index == -1) return;
    medications.update(index, model);
    medicationsMap[model.id] = model;
    _update(HomeChangeState());
  }
}
