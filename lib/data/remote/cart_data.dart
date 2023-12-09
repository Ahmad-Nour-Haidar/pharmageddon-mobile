import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class CartRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> order({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.postData(
      linkUrl: AppLink.order,
      token: token,
      data: data,
    );
    return response;
  }
}
