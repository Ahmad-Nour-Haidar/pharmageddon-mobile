import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/view/widgets/snack_bar.dart';
import '../../core/class/parent_state.dart';

void handleState({
  required ParentState state,
  required BuildContext context,
}) {
  switch (state.runtimeType) {
    case OfflineState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.error,
          message: state.message,
        ).show();
        return;
      }
    case ServerFailureState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.error,
          message: state.message,
        ).show();
        return;
      }
    case FailureState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.warning,
          message: state.message,
        ).show();
        return;
      }
    case SuccessState:
      {
        CustomSnackBar(
          context: context,
          typeSnackBar: TypeSnackBar.success,
          message: state.message,
        ).show();
        return;
      }
  }
}
