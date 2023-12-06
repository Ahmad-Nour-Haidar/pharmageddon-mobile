import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/class/validation.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_image.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_button.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_row_text_button.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_text_form_field.dart';
import '../../../controllers/auth/register_cubit/register_cubit.dart';
import '../../../controllers/auth/register_cubit/register_state.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/functions/navigator.dart';
import '../../../routes.dart';
import '../../widgets/custom_other_auth.dart';
import '../../widgets/handle_state.dart';
import '../../widgets/logo_app.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is RegisterSuccessState) {
            pushNamed(AppRoute.verifyCode, context);
          }
        },
        buildWhen: (previous, current) {
          return current is! RegisterChangeShowPasswordState;
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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
                title: AppStrings.createAccount.tr,
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
                    CustomTextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidateInput.isEmail,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: AppSvg.email,
                      hintText: AppStrings.email.tr,
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: ValidateInput.isPhone,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: AppSvg.phone,
                      hintText: AppStrings.phone.tr,
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.userNameController,
                      keyboardType: TextInputType.name,
                      validator: ValidateInput.isUsername,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: AppSvg.user,
                      hintText: AppStrings.userName.tr,
                    ),
                    const Gap(15),
                    CustomTextFormField(
                      controller: cubit.addressController,
                      keyboardType: TextInputType.text,
                      validator: ValidateInput.isAddress,
                      textInputAction: TextInputAction.next,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: AppSvg.marker,
                      hintText: AppStrings.address.tr,
                    ),
                    const Gap(15),
                    BlocSelector<RegisterCubit, RegisterState,
                        RegisterChangeShowPasswordState>(selector: (state) {
                      return RegisterChangeShowPasswordState();
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
                        hintText: AppStrings.password.tr,
                        onTapSuffix: cubit.showPassword,
                        obscureText: cubit.obscureText,
                        suffixIcon:
                            cubit.obscureText ? AppSvg.eye : AppSvg.eyeClose,
                      );
                    }),
                    const Gap(25),
                    if (state is RegisterLoadingState)
                      const SpinKitThreeBounce(
                        color: AppColor.buttonColor,
                      ),
                    if (state is! RegisterLoadingState)
                      CustomButton(
                        onTap: cubit.register,
                        text: AppStrings.register.tr,
                      ),
                    const Gap(15),
                    CustomRowTextButton(
                      text: AppStrings.haveAnAccount.tr,
                      btnText: AppStrings.loginNow.tr,
                      onTap: () {
                        // pushNamedAndRemoveUntil(AppRoute.login, context);
                        pushNamedAndRemoveUntil(AppRoute.login, context);
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
