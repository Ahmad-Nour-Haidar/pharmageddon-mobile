import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/favorite_data.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import '../../core/constant/app_request_keys.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);
  final _favoriteRemoteData = AppInjection.getIt<FavoriteRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(FavoriteState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getFavorites();
  }

  Future<void> getFavorites({bool forceGetData = false}) async {
    if (!(medications.isEmpty || forceGetData)) {
      _update(FavoriteSuccessState());
      return;
    }
    _update(FavoriteLoadingState());
    final response = await _favoriteRemoteData.getFavorites();
    response.fold((l) {
      _update(FavoriteFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.favourite_medicines];
        medications.clear();
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      }
      _update(FavoriteSuccessState());
    });
  }

  Future<void> removeFromList(MedicationModel model) async {
    if (medications.isEmpty) return;
    medications.removeWhere((element) => element.id == model.id);
    _update(FavoriteSuccessState());
  }
}
