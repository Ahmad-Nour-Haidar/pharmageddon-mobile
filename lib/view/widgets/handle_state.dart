import 'package:awesome_dialog/awesome_dialog.dart';
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
        return;
      }
    case ShowNotification:
      {
        Fluttertoast.showToast(
          msg: state.message,
          fontSize: 18,
          backgroundColor: AppColor.contentColorYellow,
          gravity: ToastGravity.TOP,
        );
        return;
        AwesomeDialog(
          context: context,
          title: state.message,
        ).show();
        return;
      }
  }
}
