import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys_request.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/favorite_data.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../model/medication_model.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final favoriteRemoteData = AppInjection.getIt<FavoriteRemoteData>();

  late final MedicationModel model;

  void initial(MedicationModel model) {
    this.model = model;
    this.model.isFavourite = this.model.isFavourite ?? false;
    this.model.price = this.model.price ?? 0.0;
    this.model.discount = this.model.discount ?? 0.0;
    this.model.priceAfterDiscount = this.model.priceAfterDiscount ?? 0.0;
    if (this.model.discount! > 0) {
      this.model.priceAfterDiscount = double.tryParse(
              this.model.priceAfterDiscount?.toStringAsFixed(2) ?? '') ??
          0.0;
    }
  }

  int q = 0;

  double get totalPrice => q * (model.price ?? 0.0);

  void changeQuantity(int x) {
    q = x;
    emit(MedicationDetailsChangeState());
  }

  void onTapFav() async {
    model.isFavourite! ? favorite() : unFavorite();
  }

  Future<void> favorite() async {
    model.isFavourite = true;
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.favorite(data: data);
    response.fold((l) {
      model.isFavourite = false;
      emit(MedicationDetailsFailureState(l));
    }, (r) {
      emit(MedicationDetailsSuccessState());
    });
  }

  Future<void> unFavorite() async {
    model.isFavourite = false;
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.favorite(data: data);
    response.fold((l) {
      model.isFavourite = true;
      emit(MedicationDetailsFailureState(l));
    }, (r) {
      emit(MedicationDetailsSuccessState());
    });
  }
}
