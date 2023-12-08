import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/favorite_data.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import '../../core/constant/app_request_keys.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  // final favoriteRemoteData = AppInjection.getIt<CartRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(CartState state) {
    if (isClosed) return;
    emit(state);
  }
}
