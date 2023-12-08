import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_request_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
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

  final favoriteRemoteData = AppInjection.getIt<FavoriteRemoteData>();
  final cartQuantityData = AppInjection.getIt<CartQuantityData>();

  late MedicationModel model;
  int quantity = 0;
  void _update(MedicationDetailsState state) {
    if (isClosed) return;
    emit(state);
  }
  void initial(MedicationModel model) {
    this.model = model;
    quantity = cartQuantityData.getQuantityOfModel(model.id);
  }

  double get totalPrice => quantity * (model.priceAfterDiscount ?? 0.0);

  void changeQuantity(int x) {
    quantity = x;
    _update(MedicationDetailsChangeState());
  }

  void onTapFav() async {
    !model.isFavourite! ? favorite() : unFavorite();
  }

  Future<void> favorite() async {
    model.isFavourite = true;
    _update(MedicationDetailsChangeState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.favorite(data: data);
    response.fold((l) {
      model.isFavourite = false;
      _update(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 404) {
        _update(MedicationDetailsFailureState(FailureState()));
      } else {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);
        _update(MedicationDetailsSuccessState());
      }
    });
  }

  Future<void> unFavorite() async {
    model.isFavourite = false;
    _update(MedicationDetailsChangeState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.unFavorite(data: data);
    response.fold((l) {
      model.isFavourite = true;
      _update(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 404) {
        _update(MedicationDetailsFailureState(FailureState()));
      } else {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);
        _update(MedicationDetailsSuccessState());

        /// this to update favorite screen if it active
        final cubit = AppInjection.getIt<FavoriteCubit>();
        if (cubit.medications.isNotEmpty) {
          cubit.deleteFromList(model);
        }
      }
    });
  }

  Future<void> addToCart() async {
    _update(MedicationDetailsLoadingState());
    try {
      await cartQuantityData.storeInCart(model.id, quantity);
      _update(MedicationDetailsSuccessState(
          state: SuccessState(message: AppStrings.savedSuccessfully.tr)));
    } catch (e) {
      _update(MedicationDetailsFailureState(FailureState()));
    }
  }
}
