import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/reset_password_cubit/reset_password_cubit.dart';
import '../../../controllers/auth/reset_password_cubit/reset_password_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/handle_state.dart';
import '../../widgets/logo_app.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<ResetPasswordCubit>()..initial(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is ResetPasswordFailureGetState) {
            handleState(context: context, state: state.state);
          }
          if (state is ResetPasswordNotVerifyState) {
            pushNamedAndRemoveUntil(AppRoute.verifyCode, context);
          }
          if (state is ResetPasswordSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! ResetPasswordChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = ResetPasswordCubit.get(context);
          final focusNode = FocusNode();
          return Container(
            decoration: const BoxDecoration(
              color: AppColor.background,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImage.backgroundMobile,
                ),
              ),
            ),
            child: Scaffold(
              backgroundColor: AppColor.transparent,
              appBar: CustomAppBar(
                title: AppStrings.resetPassword.tr,
                showOptions: false,
              ).build(),
              body: Form(
                key: cubit.formKey,
                child: ListView(
                  padding: AppPadding.screenPadding,
                  children: [
                    const LogoApp(),
                    const Gap(30),
                    if (state is ResetPasswordLoadingGetState)
                      const SpinKitFoldingCube(color: AppColor.buttonColor),
                    if (cubit.email != null)
                      Text(
                        cubit.message,
                        style: AppTextTheme.f18w500black,
                      ),
                    const Gap(20),
                    SizedBox(
                      height: 60,
                      child: FittedBox(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: OtpTextField(
                            fieldWidth: 65.0,
                            borderRadius: BorderRadius.circular(AppSize.size15),
                            numberOfFields: 6,
                            filled: true,
                            borderColor: AppColor.white,
                            focusedBorderColor: AppColor.secondColor,
                            enabledBorderColor: AppColor.white,
                            showFieldAsBox: true,
                            onSubmit: cubit.onSubmit, // end onSubmit
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    BlocSelector<ResetPasswordCubit, ResetPasswordState,
                            ResetPasswordChangeShowPasswordState>(
                        selector: (state) {
                      return ResetPasswordChangeShowPasswordState();
                    }, builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormField(
                            controller: cubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: ValidateInput.isPassword,
                            textInputAction: TextInputAction.next,
                            fillColor: AppColor.white,
                            colorPrefixIcon: AppColor.gray3,
                            onTapSuffix: cubit.showPassword,
                            obscureText: cubit.obscureText,
                            suffixIcon: cubit.obscureText
                                ? AppSvg.eye
                                : AppSvg.eyeClose,
                            prefixIcon: AppSvg.user,
                            hintText: AppStrings.password.tr,
                            onFieldSubmitted: (value) {
                              focusNode.requestFocus();
                              return null;
                            },
                          ),
                          const Gap(15),
                          CustomTextFormField(
                            controller: cubit.confirmController,
                            focusNode: focusNode,
                            keyboardType: TextInputType.visiblePassword,
                            validator: ValidateInput.isPassword,
                            textInputAction: TextInputAction.done,
                            fillColor: AppColor.white,
                            colorPrefixIcon: AppColor.gray3,
                            onTapSuffix: cubit.showPassword,
                            obscureText: cubit.obscureText,
                            suffixIcon: cubit.obscureText
                                ? AppSvg.eye
                                : AppSvg.eyeClose,
                            prefixIcon: AppSvg.user,
                            hintText: AppStrings.confirm.tr,
                          ),
                        ],
                      );
                    }),
                    Align(
                      alignment: isEnglish()
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          cubit.getVerifyCode();
                        },
                        child: Text(
                          AppStrings.resendVerifyCode.tr,
                          style: AppTextTheme.f16w600TextColor2,
                        ),
                      ),
                    ),
                    const Gap(25),
                    if (state is ResetPasswordLoadingState)
                      const SpinKitThreeBounce(color: AppColor.buttonColor),
                    if (state is! ResetPasswordLoadingState)
                      CustomButton(
                        onTap: cubit.reset,
                        text: AppStrings.reset.tr,
                      ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
