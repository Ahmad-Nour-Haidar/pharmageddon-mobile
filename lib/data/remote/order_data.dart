import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class OrderRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getOrders() async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      // todo: url
      linkUrl: AppLink.order,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getOrderDetails({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      // todo: url
      linkUrl: AppLink.order,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }
}
