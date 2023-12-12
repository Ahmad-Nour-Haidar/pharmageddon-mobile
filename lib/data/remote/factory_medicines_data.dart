import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import 'package:pharmageddon_mobile/data/static_data/medicines.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class FactoryMedicinesRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedicines({
    Map<String, dynamic>? queryParameters,
  }) async {
    // todo
    return Right(medicines);
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.getAllMedicinesOfManufacturer,
      queryParameters: queryParameters,
      token: token,
    );
    return response;
  }
}
