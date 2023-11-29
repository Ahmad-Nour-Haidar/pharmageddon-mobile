import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import '../functions/random_loading.dart';
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
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }
}

class CrudWithHttp {
  // Future<Either<ParentState, Map<String, dynamic>>> postData({
//   required String linkUrl,
//   String? token,
//   required Map data,
// }) async {
//   // if (!await checkInternet()) {
//   //   return Left(OfflineState(tr));
//   // }
//   if (token != null) {
//     _headers.addAll({
//       'Authorization': 'Bearer $token',
//     });
//   }
//   await randomLoading();
//   try {
//     final body = json.encode(data), link = Uri.parse(linkUrl);
//     final response = await http.post(link, body: body, headers: _headers);
//     printme.cyan(response.statusCode);
//     // printme.printFullText(response.body);
//     if (!(response.statusCode == 200 || response.statusCode == 201)) {
//       return Left(ServerFailureState());
//     }
//     final responseBody = json.decode(response.body);
//     // printme.blue(responseBody);
//     return Right(responseBody);
//   } catch (e) {
//     printme.red(e);
//     return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//   }
// }
//
// Future<Either<ParentState, Map<String, dynamic>>> getData({
//   required String linkUrl,
//   String? token,
// }) async {
//   // if (!await checkInternet()) {
//   //   return Left(OfflineState(tr));
//   // }
//   if (token != null) {
//     _headers.addAll({
//       'Authorization': 'Bearer $token',
//     });
//   }
//   await randomLoading();
//   try {
//     final response = await http.get(Uri.parse(linkUrl), headers: _headers);
//     printme.cyan(response.statusCode);
//     if (!(response.statusCode == 200 || response.statusCode == 201)) {
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//     final responseBody = json.decode(response.body);
//     return Right(responseBody);
//   } catch (e) {
//     printme.red(e);
//     return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//   }
// }
//
// Future<Either<ParentState, Map<String, dynamic>>> deleteData({
//   required Map data,
//   required String linkUrl,
//   String? token,
// }) async {
//   // if (!await checkInternet()) {
//   //   return Left(OfflineState(tr));
//   // }
//   if (token != null) {
//     _headers.addAll({
//       'Authorization': 'Bearer $token',
//     });
//   }
//   try {
//     final body = json.encode(data), link = Uri.parse(linkUrl);
//     final response = await http.delete(link, body: body, headers: _headers);
//     printme.cyan(response.statusCode);
//     if (!(response.statusCode == 200 || response.statusCode == 201)) {
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//     final responseBody = json.decode(response.body);
//     return Right(responseBody);
//   } catch (e) {
//     printme.red(e);
//     return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//   }
// }
//
//   Future<Either<ParentState, Map<String, dynamic>>> addRequestWithImageOne({
//     required Map data,
//     required String url,
//     required File? image,
//     String? token,
//     String nameRequest = "files",
//     String typeMethod = "POST",
//   }) async {
//     final uri = Uri.parse(url);
//     final request = http.MultipartRequest(typeMethod, uri);
//     if (image != null) {
//       final length = await image.length();
//       final stream = http.ByteStream(image.openRead());
//       stream.cast();
//       final multipartFile = http.MultipartFile(nameRequest, stream, length,
//           filename: basename(image.path));
//       request.files.add(multipartFile);
//     }
//     if (token != null) {
//       _headers.addAll({
//         'Authorization': 'Bearer $token',
//       });
//     }
//     _headers.forEach((key, value) {
//       request.headers[key] = value;
//     });
//
//     // add Data to request
//     data.forEach((key, value) {
//       request.fields[key] = value;
//     });
//     // add Data to request
//     // Send Request
//     final myRequest = await request.send();
//     // For get Response Body
//     final response = await http.Response.fromStream(myRequest);
//     if (!(response.statusCode == 200 || response.statusCode == 201)) {
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//     try {
//       final responseBody = json.decode(response.body);
//       return Right(responseBody);
//     } catch (e) {
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//   }
}
