import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';

import '../../core/constant/app_request_keys.dart';
import '../../data/remote/factory_medicines_data.dart';
import 'manufacturer_medicines_state.dart';

class ManufacturerMedicinesCubit extends Cubit<ManufacturerMedicinesState> {
  ManufacturerMedicinesCubit() : super(FactoryMedicinesInitialState());

  static ManufacturerMedicinesCubit get(BuildContext context) =>
      BlocProvider.of(context);
  late final ManufacturerModel model;

  final List<MedicationModel> medications = [];

  final _effectMedicinesRemoteData =
      AppInjection.getIt<ManufacturerMedicinesRemoteData>();

  void _update(ManufacturerMedicinesState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(ManufacturerModel model) {
    this.model = model;
    getMedications();
  }

  Future<void> getMedications({bool forceGetData = false}) async {
    if (!(medications.isEmpty || forceGetData)) {
      _update(FactoryMedicinesSuccessState());
      return;
    }
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    _update(FactoryMedicinesLoadingState());
    final response = await _effectMedicinesRemoteData.getMedicines(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(FactoryMedicinesFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        medications.clear();
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      }
      _update(FactoryMedicinesSuccessState());
    });
  }
}
