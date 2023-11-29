import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';

enum TypeSnackBar {
  warning,
  error,
  success,
}

OverlayEntry? _previousEntry;

class CustomSnackBar {
  static const _durationShow = Duration(seconds: 5);

  final BuildContext context;
  final TypeSnackBar typeSnackBar;
  final String message;
  final IconData? iconData;

  CustomSnackBar({
    required this.context,
    required this.typeSnackBar,
    required this.message,
    this.iconData,
  });

  void _remove() {
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }
  }

  void show() {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          left: AppSize.screenPadding,
          child: FadeIn(
            duration: const Duration(milliseconds: 200),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                _remove();
              },
              child: GestureDetector(
                onTap: _remove,
                child: SnackBarBody(
                  message: message,
                  typeSnackBar: typeSnackBar,
                  iconData: iconData,
                ),
              ),
            ),
          ),
        );
        // return Positioned(
        //   top: 0.0,
        //   left: AppSize.width * 0.2,
        //   child: Center(
        //     child: ,
        //   ),
        // );
      },
    );
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }
    overlayState.insert(overlayEntry);
    _previousEntry = overlayEntry;
    Future.delayed(_durationShow, () async {
      _remove();
    });
  }
}

class SnackBarBody extends StatelessWidget {
  const SnackBarBody({
    super.key,
    required this.typeSnackBar,
    required this.message,
    this.iconData,
  });

  final TypeSnackBar typeSnackBar;
  final String message;
  final IconData? iconData;

  SnackBarContent getBody(TypeSnackBar typeSnackBar) {
    switch (typeSnackBar) {
      case TypeSnackBar.error:
        return SnackBarContent(
          color: AppColor.red,
          message: message,
          iconData: iconData,
        );
      case TypeSnackBar.success:
        return SnackBarContent(
          color: AppColor.green,
          message: message,
          iconData: iconData,
        );
      case TypeSnackBar.warning:
        return SnackBarContent(
          color: AppColor.snackbarColor,
          message: message,
          iconData: iconData,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.radius15),
        color: AppColor.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: getBody(typeSnackBar),
          ),
        ),
      ),
    );
  }
}

class SnackBarContent extends StatelessWidget {
  const SnackBarContent({
    super.key,
    required this.color,
    required this.message,
    this.iconData,
  });

  final IconData? iconData;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.padding20),
      padding: const EdgeInsets.all(AppSize.padding10),
      width: AppSize.width - (2 * AppSize.screenPadding),
      // height: AppSize.size60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSize.radius15),
      ),
      child: Row(
        children: [
          if (iconData != null)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSize.padding20),
              child: Icon(
                iconData,
                color: AppColor.white,
                size: AppSize.size30,
              ),
            ),
          Expanded(
            child: Text(
              message,
              textAlign: iconData == null ? TextAlign.center : null,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
