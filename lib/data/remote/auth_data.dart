import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/constant/app_request_keys.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class AuthRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> login({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crud.postData(
      data: data,
      linkUrl: AppLink.login,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> register({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crud.postData(
      data: data,
      linkUrl: AppLink.register,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> verify({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crud.postData(
      data: data,
      linkUrl: AppLink.checkVerifyCode,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getVerificationCode({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crud.postData(
      data: data,
      linkUrl: AppLink.sendVerificationCode,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> checkEmail({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crud.postData(
      data: data,
      linkUrl: AppLink.checkEmail,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> resetPassword({
    required Map<String, dynamic> data,
  }) async {
    var response = await _crud.postData(
      data: data,
      linkUrl: AppLink.resetPassword,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> update({
    required Map<String, dynamic> data,
    File? file,
  }) async {
    final token = AppLocalData.user!.authorization!;
    return await _crud.postRequestWithFile(
      data: data,
      token: token,
      linkUrl: AppLink.update,
      file: file,
      nameKey: AppRKeys.image,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> logout() async {
    final token = AppLocalData.user!.authorization!;
    var response = await _crud.deleteData(
      data: {},
      token: token,
      linkUrl: AppLink.logout,
    );
    return response;
  }
}
