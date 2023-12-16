import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class OrderRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> createOrder({
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

  Future<Either<ParentState, Map<String, dynamic>>> getOrders({
    required String url,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: url,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getOrderDetails({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.orderGetOrderDetails,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> cancelOrder({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.orderDelete,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> deleteMedicineInOrder({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user!.authorization!;
    final response = await _crud.getData(
      linkUrl: AppLink.orderDeleteMedicine,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }
}
