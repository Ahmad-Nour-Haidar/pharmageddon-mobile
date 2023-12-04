import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../factory_medicines_cubit/effect_medicines_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  int? medicationId;

  void initial(int medicationId) {
    this.medicationId = medicationId;
  }

  int q = 0;

  void changeQuantity(int x) {
    q = x;
    emit(MedicationDetailsChangeState());
  }
}
