import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class FavoriteRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getFavorites() async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.favoriteGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> favorite({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.postData(
      linkUrl: AppLink.favorite,
      data: data,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> unFavorite({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.deleteData(
      linkUrl: AppLink.unFavorite,
      data: data,
      token: token,
    );
    return response;
  }
}
