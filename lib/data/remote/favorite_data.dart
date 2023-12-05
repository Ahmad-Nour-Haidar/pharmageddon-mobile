import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import '../crud_dio.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';

class FavoriteRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getFavorites() async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      // todo change url
      linkUrl: AppLink.login,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> favorites({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.postData(
      // todo change url
      linkUrl: AppLink.login,
      data: data,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> unFavorites({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.postData(
      // todo change url
      linkUrl: AppLink.login,
      data: data,
      token: token,
    );
    return response;
  }
}
