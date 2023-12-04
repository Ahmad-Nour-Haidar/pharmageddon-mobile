// class CrudWithHttp {
//   Future<Either<ParentState, Map<String, dynamic>>> postData({
//     required String linkUrl,
//     String? token,
//     required Map data,
//   }) async {
//     // if (!await checkInternet()) {
//     //   return Left(OfflineState(tr));
//     // }
//     if (token != null) {
//       _headers.addAll({
//         'Authorization': 'Bearer $token',
//       });
//     }
//     await randomLoading();
//     try {
//       final body = json.encode(data), link = Uri.parse(linkUrl);
//       final response = await http.post(link, body: body, headers: _headers);
//       printme.cyan(response.statusCode);
//       // printme.printFullText(response.body);
//       if (!(response.statusCode == 200 || response.statusCode == 201)) {
//         return Left(ServerFailureState());
//       }
//       final responseBody = json.decode(response.body);
//       // printme.blue(responseBody);
//       return Right(responseBody);
//     } catch (e) {
//       printme.red(e);
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//   }
//
//   Future<Either<ParentState, Map<String, dynamic>>> getData({
//     required String linkUrl,
//     String? token,
//   }) async {
//     // if (!await checkInternet()) {
//     //   return Left(OfflineState(tr));
//     // }
//     if (token != null) {
//       _headers.addAll({
//         'Authorization': 'Bearer $token',
//       });
//     }
//     await randomLoading();
//     try {
//       final response = await http.get(Uri.parse(linkUrl), headers: _headers);
//       printme.cyan(response.statusCode);
//       if (!(response.statusCode == 200 || response.statusCode == 201)) {
//         return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//       }
//       final responseBody = json.decode(response.body);
//       return Right(responseBody);
//     } catch (e) {
//       printme.red(e);
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//   }
//
//   Future<Either<ParentState, Map<String, dynamic>>> deleteData({
//     required Map data,
//     required String linkUrl,
//     String? token,
//   }) async {
//     // if (!await checkInternet()) {
//     //   return Left(OfflineState(tr));
//     // }
//     if (token != null) {
//       _headers.addAll({
//         'Authorization': 'Bearer $token',
//       });
//     }
//     try {
//       final body = json.encode(data), link = Uri.parse(linkUrl);
//       final response = await http.delete(link, body: body, headers: _headers);
//       printme.cyan(response.statusCode);
//       if (!(response.statusCode == 200 || response.statusCode == 201)) {
//         return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//       }
//       final responseBody = json.decode(response.body);
//       return Right(responseBody);
//     } catch (e) {
//       printme.red(e);
//       return Left(ServerFailureState(AppStrings.somethingWentWrong.tr));
//     }
//   }
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
// }
