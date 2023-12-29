import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class FavoriteRemoteData {
  final _crud = AppInjection.getIt<CrudDio>();

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
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.unFavorite,
      queryParameters: queryParameters,
      token: token,
    );
    return response;
  }
}
