import 'package:get/get.dart';

import '../constant/app_strings.dart';

abstract class ParentState {
  final String message;

  ParentState({this.message = ''});
}

class OfflineState extends ParentState {
  OfflineState({String? message})
      : super(message: message ?? AppStrings.youAreOffline.tr);
}

class ServerFailureState extends ParentState {
  ServerFailureState({String? message})
      : super(message: message ?? AppStrings.somethingWentWrong.tr);
}

class FailureState extends ParentState {
  FailureState({String? message})
      : super(message: message ?? AppStrings.somethingWentWrong.tr);
}

class NoneState extends ParentState {
  NoneState({String? message})
      : super(message: message ?? AppStrings.youAreOffline.tr);
}

class SuccessState extends ParentState {
  SuccessState({String? message})
      : super(message: message ?? AppStrings.done.tr);
}

class WarningState extends ParentState {
  WarningState({String? message})
      : super(message: message ?? AppStrings.done.tr);
}
