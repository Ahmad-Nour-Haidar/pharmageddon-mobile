import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys_request.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/favorite_data.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../core/class/parent_state.dart';
import '../../model/medication_model.dart';
import '../favorite_cubit/favorite_cubit.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final favoriteRemoteData = AppInjection.getIt<FavoriteRemoteData>();

  late MedicationModel model;

  void initial(MedicationModel model) {
    this.model = model;
  }

  int quantity = 0;

  double get totalPrice => quantity * (model.priceAfterDiscount ?? 0.0);

  void changeQuantity(int x) {
    quantity = x;
    emit(MedicationDetailsChangeState());
  }

  void onTapFav() async {
    !model.isFavourite! ? favorite() : unFavorite();
  }

  Future<void> favorite() async {
    model.isFavourite = true;
    emit(MedicationDetailsChangeState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.favorite(data: data);
    response.fold((l) {
      model.isFavourite = false;
      emit(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 404) {
        emit(MedicationDetailsFailureState(FailureState()));
      } else {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);
        emit(MedicationDetailsSuccessState());
      }
    });
  }

  Future<void> unFavorite() async {
    model.isFavourite = false;
    emit(MedicationDetailsChangeState());
    final data = {
      AppRKeys.id: model.id,
    };
    final response = await favoriteRemoteData.unFavorite(data: data);
    response.fold((l) {
      model.isFavourite = true;
      emit(MedicationDetailsFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 404) {
        emit(MedicationDetailsFailureState(FailureState()));
      } else {
        final json = r[AppRKeys.data][AppRKeys.favourite_medicine];
        model = MedicationModel.fromJson(json);
        emit(MedicationDetailsSuccessState());

        /// this to update favorite screen if it active
        final cubit = AppInjection.getIt<FavoriteCubit>();
        if (cubit.medications.isNotEmpty) {
          cubit.deleteFromList(model);
        }
      }
    });
  }
}
