import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/local/cart_quantity_data.dart';
import 'package:pharmageddon_mobile/data/remote/favorite_data.dart';
import '../../core/class/parent_state.dart';
import '../../model/medication_model.dart';
import '../favorite_cubit/favorite_cubit.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final _favoriteRemoteData = AppInjection.getIt<FavoriteRemoteData>();
  final _cartQuantityData = AppInjection.getIt<CartQuantityData>();

  late MedicationModel model;
  int quantity = 0;

  void _update(MedicationDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(MedicationModel model) {
    this.model = model;
    quantity = _cartQuantityData.getQuantityOfModel(model.id);
    quantity = min(quantity, this.model.availableQuantity!);
    addToCart(state: NoneState());
  }

  double get totalPrice => quantity * (model.priceAfterDiscount ?? 0.0);

  void changeQuantity(int x) {
    quantity = x;
    _update(MedicationDetailsChangeState());
  }

  void onTapFav() => model.isFavourite! ? unFavorite() : favorite();

  Future<void> favorite() async {
    model.isFavourite = true;
    _update(MedicationDetailsChangeState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await _favoriteRemoteData.favorite(data: data);
    response.fold((l) {
      model.isFavourite = false;
      _update(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 200) {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);

        // this to update medications list
        AppInjection.getIt<HomeCubit>().updateMedicationModel(model);
        _update(MedicationDetailsSuccessState());
      } else {
        _update(MedicationDetailsFailureState(FailureState()));
      }
    });
  }

  Future<void> unFavorite() async {
    model.isFavourite = false;
    _update(MedicationDetailsChangeState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response =
        await _favoriteRemoteData.unFavorite(queryParameters: queryParameters);
    response.fold((l) {
      model.isFavourite = true;
      _update(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 404) {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);
        _update(MedicationDetailsSuccessState());
        // this to update medications list
        AppInjection.getIt<HomeCubit>().updateMedicationModel(model);
        // this to update favorite screen if it active
        AppInjection.getIt<FavoriteCubit>().removeFromList(model);
      } else {
        _update(MedicationDetailsFailureState(FailureState()));
      }
    });
  }

  Future<void> addToCart({ParentState? state}) async {
    _update(MedicationDetailsLoadingState());
    try {
      await _cartQuantityData.storeInCart(model.id, quantity);
      _update(MedicationDetailsSuccessState(
          state: state ?? SuccessState(message: AppText.savedSuccessfully.tr)));
    } catch (e) {
      _update(MedicationDetailsFailureState(FailureState()));
    }
  }
}
