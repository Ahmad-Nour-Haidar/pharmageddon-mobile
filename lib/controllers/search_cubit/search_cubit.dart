import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/search_data.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import '../../core/constant/app_request_keys.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);
  final _searchRemoteData = AppInjection.getIt<SearchRemoteData>();
  final List<MedicationModel> medications = [];

  Future<void> search(String value) async {
    emit(SearchLoadingState());
    final queryParameters = {
      AppRKeys.q: value,
    };
    final response = await _searchRemoteData.search(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      emit(SearchFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 403) {
        emit(SearchNoDataState(value));
        return;
      }
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      if (medications.isEmpty) {
        emit(SearchNoDataState(value));
      } else {
        emit(SearchSuccessState(value));
      }
    });
  }
}
