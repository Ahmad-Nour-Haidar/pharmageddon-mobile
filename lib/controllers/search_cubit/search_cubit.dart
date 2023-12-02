import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/print.dart';
import '../../core/class/parent_state.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  List data = [];

  Future<void> search(String value) async {
    emit(SearchLoadingState());
    await Future.delayed(const Duration(seconds: 3), () {
      emit(SearchSuccessState(value));
    });
    await Future.delayed(const Duration(seconds: 3), () {
      data.add(1);
      emit(SearchSuccessState(value));
    });
    await Future.delayed(const Duration(seconds: 3), () {
      emit(SearchFailureState(OfflineState()));
    });
  }
}
