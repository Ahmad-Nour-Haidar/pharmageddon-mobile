import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';

import '../../../controllers/auth/login_cubit/login_cubit.dart';
import '../../../controllers/auth/login_cubit/login_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_other_auth.dart';
import '../../widgets/custom_row_text_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_toggle_button.dart';
import '../../widgets/logo_app.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is LoginNotVerifyState) {
            pushNamed(AppRoute.verifyCode, context);
          }
          if (state is LoginSuccessState) {
            pushNamed(AppRoute.home, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! LoginChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
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
                title: AppText.login.tr,
                showArrowBack: false,
                showOptions: false,
              ).build(),
              body: Form(
                key: cubit.formKey,
                child: ListView(
                  padding: AppPadding.screenPadding,
                  children: [
                    const LogoApp(),
                    const Gap(30),
                    CustomToggleButton(
                      onTap: cubit.changeIsEmail,
                      isEmail: cubit.isEmail,
                    ),
                    const Gap(20),
                    CustomTextFormField(
                      controller: cubit.emPhController,
                      keyboardType: cubit.isEmail
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      validator: cubit.isEmail
                          ? ValidateInput.isEmail
                          : ValidateInput.isPhone,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: cubit.isEmail ? AppSvg.email : AppSvg.phone,
                      hintText:
                          cubit.isEmail ? AppText.email.tr : AppText.phone.tr,
                    ),
                    const Gap(15),
                    BlocSelector<LoginCubit, LoginState,
                        LoginChangeShowPasswordState>(selector: (state) {
                      return LoginChangeShowPasswordState();
                      // return selected state based on the provided state.
                    }, builder: (context, state) {
                      return CustomTextFormField(
                        controller: cubit.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: ValidateInput.isPassword,
                        textInputAction: TextInputAction.done,
                        fillColor: AppColor.white,
                        colorPrefixIcon: AppColor.gray3,
                        prefixIcon: AppSvg.user,
                        hintText: AppText.password.tr,
                        onTapSuffix: cubit.showPassword,
                        obscureText: cubit.obscureText,
                        suffixIcon:
                            cubit.obscureText ? AppSvg.eye : AppSvg.eyeClose,
                      );
                    }),
                    Align(
                      alignment: isEnglish()
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          pushNamed(AppRoute.checkEmail, context);
                        },
                        child: Text(
                          AppText.forgetPassword.tr,
                          style: AppTextStyle.f16w600TextColor2,
                        ),
                      ),
                    ),
                    const Gap(25),
                    if (state is LoginLoadingState)
                      const SpinKitThreeBounce(color: AppColor.buttonColor),
                    if (state is! LoginLoadingState)
                      CustomButton(
                        onTap: cubit.login,
                        text: AppText.login.tr,
                      ),
                    const Gap(15),
                    CustomRowTextButton(
                      text: AppText.doNotHaveAnAccount.tr,
                      btnText: AppText.createAccount.tr,
                      onTap: () {
                        pushNamedAndRemoveUntil(AppRoute.register, context);
                      },
                    ),
                    const CustomOtherAuth(),
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
