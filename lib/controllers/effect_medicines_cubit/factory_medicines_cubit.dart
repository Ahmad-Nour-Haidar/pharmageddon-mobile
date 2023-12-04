import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'factory_medicines_state.dart';

class FactoryMedicinesCubit extends Cubit<FactoryMedicinesState> {
  FactoryMedicinesCubit() : super(FactoryMedicinesInitialState());

  static FactoryMedicinesCubit get(BuildContext context) =>
      BlocProvider.of(context);
  int? medicationId;

  void initial(int medicationId) {
    this.medicationId = medicationId;
  }
}
