import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../medication_details_cubit/medication_details_state.dart';

class EffectMedicinesCubit extends Cubit<EffectMedicinesState> {
  EffectMedicinesCubit() : super(EffectMedicinesInitialState());

  static EffectMedicinesCubit get(BuildContext context) =>
      BlocProvider.of(context);
  int? medicationId;

  void initial(int medicationId) {
    this.medicationId = medicationId;
  }
}
