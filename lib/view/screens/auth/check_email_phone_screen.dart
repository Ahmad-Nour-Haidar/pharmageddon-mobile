import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controllers/auth/check_email_cubit/check_email_cubit.dart';
import '../../../controllers/auth/check_email_cubit/check_email_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_toggle_button.dart';
import '../../widgets/handle_state.dart';
import '../../widgets/logo_app.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<CheckEmailCubit>(),
      child: BlocConsumer<CheckEmailCubit, CheckEmailState>(
        listener: (context, state) {
          if (state is CheckEmailFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is CheckEmailSuccessState) {
            pushNamed(AppRoute.resetPassword, context);
          }
        },
        builder: (context, state) {
          final cubit = CheckEmailCubit.get(context);
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
                title: AppText.checkEmail.tr,
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
                      controller: cubit.emPHController,
                      keyboardType: cubit.isEmail
                          ? TextInputType.emailAddress
                          : TextInputType.name,
                      validator: cubit.isEmail
                          ? ValidateInput.isEmail
                          : ValidateInput.isPhone,
                      textInputAction: TextInputAction.done,
                      fillColor: AppColor.white,
                      colorPrefixIcon: AppColor.gray3,
                      prefixIcon: cubit.isEmail ? AppSvg.email : AppSvg.phone,
                      hintText:
                          cubit.isEmail ? AppText.email.tr : AppText.phone.tr,
                    ),
                    const Gap(25),
                    if (state is CheckEmailLoadingState)
                      const SpinKitThreeBounce(color: AppColor.buttonColor),
                    if (state is! CheckEmailLoadingState)
                      CustomButton(
                        onTap: cubit.check,
                        text: AppText.check.tr,
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
