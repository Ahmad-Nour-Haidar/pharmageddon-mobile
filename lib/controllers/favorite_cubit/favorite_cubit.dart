import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(BuildContext context) => BlocProvider.of(context);

  List data = [];

  Future<void> search(String value) async {
    emit(FavoriteLoadingState());
    // await Future.delayed(const Duration(seconds: 3), () {
    //   emit(FavoriteSuccessState(value));
    // });
    await Future.delayed(const Duration(seconds: 3), () {
      data.add(1);
      emit(FavoriteSuccessState(value));
    });
    // await Future.delayed(const Duration(seconds: 3), () {
    //   emit(FavoriteFailureState(OfflineState()));
    // });
  }
}
