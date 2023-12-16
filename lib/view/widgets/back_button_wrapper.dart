import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import '../../core/constant/app_color.dart';

class BackButtonWrapper extends StatefulWidget {
  final Widget child;

  const BackButtonWrapper({
    super.key,
    required this.child,
  });

  @override
  State<BackButtonWrapper> createState() => _BackButtonWrapperState();
}

class _BackButtonWrapperState extends State<BackButtonWrapper> {
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        final now = DateTime.now();
        final difference = now.difference(timeBackPressed).inSeconds;
        final isWarning = difference >= 2;
        timeBackPressed = DateTime.now();
        if (isWarning) {
          Fluttertoast.showToast(
            msg: AppText.pressBackAgainToExit.tr,
            fontSize: 18,
            backgroundColor: AppColor.snackbarColor,
          );
        } else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
