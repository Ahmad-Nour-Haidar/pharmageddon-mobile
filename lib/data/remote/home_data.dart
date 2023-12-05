import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import '../crud_dio.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';

class HomeRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedications() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllMedicine,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getEffectsCategories() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllEffectCategories,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllManufacturer,
      token: token,
    );
    return response;
  }
}
