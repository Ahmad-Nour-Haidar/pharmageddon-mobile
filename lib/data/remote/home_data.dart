import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import 'package:pharmageddon_mobile/data/static_data/effect_category.dart';
import 'package:pharmageddon_mobile/data/static_data/manufacturer.dart';
import 'package:pharmageddon_mobile/data/static_data/medicines.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class HomeRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedications() async {
    return Right(medicines);
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllMedicine,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getEffectsCategories() async {
    return Right(effectCategory);
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllEffectCategories,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers() async {
    return Right(manufacturer);
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllManufacturer,
      token: token,
    );
    return response;
  }
}
