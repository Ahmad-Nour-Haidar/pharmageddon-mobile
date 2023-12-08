import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/model/effect_category_model.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../core/constant/app_request_keys.dart';
import '../../data/remote/effect_medicines_data.dart';
import 'effect_medicines_state.dart';

class EffectMedicinesCubit extends Cubit<EffectMedicinesState> {
  EffectMedicinesCubit() : super(EffectMedicinesInitialState());

  static EffectMedicinesCubit get(BuildContext context) =>
      BlocProvider.of(context);
  void _update(EffectMedicinesState state) {
    if (isClosed) return;
    emit(state);
  }
  late final EffectCategoryModel model;

  String get title => getEffectCategoryModelName(model);

  final List<MedicationModel> medications = [];

  final effectMedicinesRemoteData =
      AppInjection.getIt<EffectMedicinesRemoteData>();

  void initial(EffectCategoryModel model) {
    this.model = model;
    getMedications();
  }

  Future<void> getMedications({bool forceGetData = false}) async {
    if (!(medications.isEmpty || forceGetData)) {
      _update(EffectMedicinesSuccessState());
      return;
    }
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    _update(EffectMedicinesLoadingState());
    final response = await effectMedicinesRemoteData.getMedicines(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(EffectMedicinesFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      medications.shuffle();
      if (medications.isEmpty) {
        _update(EffectMedicinesNoDataState());
      } else {
        _update(EffectMedicinesSuccessState());
      }
    });
  }
}
