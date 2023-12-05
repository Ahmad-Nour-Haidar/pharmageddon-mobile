import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/medication_model.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  late final MedicationModel model;

  void initial(MedicationModel model) {
    this.model = model;
  }

  int q = 0;

  double get totalPrice => q * (model.price ?? 0.0);

  void changeQuantity(int x) {
    q = x;
    emit(MedicationDetailsChangeState());
  }
}
