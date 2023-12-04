import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import '../core/functions/random_loading.dart';
import 'package:pharmageddon_mobile/print.dart';

class Crud {
  final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Charset": "utf-8",
    "Connection": "Keep-Alive",
    'Accept': 'application/json',
    // 'Content-Type': 'application/json',
    // 'Keep-Alive': 'timeout=5, max=50',
  };

  static late final Dio _dio;

  Crud() {
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
      final link = Uri.parse(linkUrl);
      final response = await _dio.postUri(link, data: data);
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
      final link = Uri.parse(linkUrl);
      final response = await _dio.getUri(link);
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
      final link = Uri.parse(linkUrl);
      final response = await _dio.deleteUri(link, data: data);
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
      final link = Uri.parse(linkUrl);
      final response = await _dio.postUri(link, data: formData);
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