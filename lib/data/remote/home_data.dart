import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class HomeRemoteData {
  final _crud = AppInjection.getIt<CrudDio>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedications() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getDiscount() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineGetAllDiscount,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getEffectsCategories() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.effectCategoriesGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.manufacturerGetAll,
      token: token,
    );
    return response;
  }
}
