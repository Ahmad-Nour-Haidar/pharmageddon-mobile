import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_color.dart';

void handleState({
  required ParentState state,
  required BuildContext context,
}) {
  Fluttertoast.cancel();
  switch (state.runtimeType) {
    case OfflineState:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.red,
          gravity: ToastGravity.TOP,
        );
        // CustomSnackBar(
        //   context: context,
        //   typeSnackBar: TypeSnackBar.error,
        //   message: state.message,
        // ).show();
        return;
      }
    case ServerFailureState:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.red,
          gravity: ToastGravity.TOP,
        );
        // CustomSnackBar(
        //   context: context,
        //   typeSnackBar: TypeSnackBar.error,
        //   message: state.message,
        // ).show();
        return;
      }
    case FailureState:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.red,
          gravity: ToastGravity.TOP,
        );
        // CustomSnackBar(
        //   context: context,
        //   typeSnackBar: TypeSnackBar.warning,
        //   message: state.message,
        // ).show();
        return;
      }
    case SuccessState:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.green,
          gravity: ToastGravity.TOP,
        );
        // CustomSnackBar(
        //   context: context,
        //   typeSnackBar: TypeSnackBar.success,
        //   message: state.message,
        // ).show();
        return;
      }
    case WarningState:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.contentColorYellow,
          gravity: ToastGravity.TOP,
        );
        // CustomSnackBar(
        //   context: context,
        //   typeSnackBar: TypeSnackBar.warning,
        //   message: state.message,
        // ).show();
        return;
      }
  }
}
