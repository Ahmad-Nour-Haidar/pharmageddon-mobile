import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../core/functions/random_loading.dart';

class CrudDio {
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Charset": "utf-8",
    "Connection": "Keep-Alive",
    'Accept': 'application/json',
    // 'Content-Type': 'application/json',
    // 'Keep-Alive': 'timeout=5, max=50',
  };

  static late final Dio _dio;

  CrudDio() {
    _dio = Dio(BaseOptions(headers: _headers));
  }

  Future<Either<ParentState, Map<String, dynamic>>> postData({
    required String linkUrl,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState());
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response = await _dio.post(linkUrl, data: data);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> getData({
    required String linkUrl,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState(tr));
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response =
          await _dio.get(linkUrl, queryParameters: queryParameters);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> deleteData({
    required String linkUrl,
    required Map data,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState());
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response = await _dio.delete(linkUrl, data: data);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> postRequestWithFile({
    required String linkUrl,
    required Map<String, dynamic> data,
    required File? file,
    String nameKey = "file",
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState(tr));
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    final formData = FormData.fromMap(data);
    if (file != null) {
      final fileName = file.path.split('/').last;
      formData.files.addAll({
        nameKey: await MultipartFile.fromFile(file.path, filename: fileName),
      }.entries);
    }
    await randomLoading();
    try {
      final response = await _dio.post(linkUrl, data: formData);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }
}
