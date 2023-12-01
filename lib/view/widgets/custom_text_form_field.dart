import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/functions/functions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.textInputAction,
    required this.fillColor,
    required this.colorPrefixIcon,
    required this.prefixIcon,
    required this.hintText,
    this.onFieldSubmitted,
    this.textDirection,
    this.onTapSuffix,
    this.suffixIcon,
    this.obscureText,
    this.sizePrefix = AppSize.size20,
    this.hintStyle,
    this.borderRadius = AppSize.radius10,
    this.contentPadding = AppPadding.zero,
    this.height,
    this.onTap,
    this.onTapPrefix,
    this.enabled = true,
    this.focusNode,
  });

  final void Function()? onTapSuffix;
  final void Function()? onTapPrefix;
  final String? Function(String?) validator;
  final String? Function(String?)? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color fillColor;
  final Color colorPrefixIcon;
  final String? prefixIcon;
  final String? suffixIcon;
  final String hintText;
  final bool? obscureText;
  final double sizePrefix;
  final double? height;
  final double borderRadius;
  final TextDirection? textDirection;
  final TextStyle? hintStyle;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final void Function()? onTap;
  final FocusNode? focusNode;

  TextDirection get getDirectionality {
    if (textDirection != null) {
      return textDirection!;
    }
    if (isEnglish()) {
      return TextDirection.ltr;
    }
    return TextDirection.rtl;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getDirectionality,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        onTap: onTap,
        // onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textDirection: getTextDirection(controller.text),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          // helperText: " ",
          errorMaxLines: 3,
          fillColor: fillColor,
          filled: true,
          // contentPadding: contentPadding,
          // hintTextDirection:
          //     isEnglish() ? TextDirection.ltr : TextDirection.rtl,
          prefixIcon: prefixIcon != null
              ? IconButton(
                  padding: AppPadding.zero,
                  onPressed: onTapPrefix,
                  icon: SvgImage(
                    path: prefixIcon!,
                    color: AppColor.gray1,
                    size: 20,
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: onTapSuffix,
                  child: Padding(
                    padding: AppPadding.padding10,
                    child: SvgImage(
                      path: suffixIcon!,
                      color: AppColor.gray3,
                      size: 24,
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColor.gray2, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColor.gray2, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColor.gray2, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColor.red, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColor.red, width: 1),
          ),
        ),
      ),
    );
  }
}
