import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import '../../../controllers/auth/verify_code_cubit/verify_code_cubit.dart';
import '../../../controllers/auth/verify_code_cubit/verify_code_state.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_image.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/logo_app.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<VerifyCodeCubit>()..initial(),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeFailureGetState) {
            handleState(context: context, state: state.state);
          }
          if (state is VerifyCodeFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is VerifyCodeSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        builder: (context, state) {
          final cubit = VerifyCodeCubit.get(context);
          return Container(
            decoration: const BoxDecoration(
              color: AppColor.background,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImage.backgroundMobile),
              ),
            ),
            child: Scaffold(
              backgroundColor: AppColor.transparent,
              appBar: CustomAppBar(
                title: AppText.verifyCode.tr,
                showOptions: false,
              ).build(),
              body: ListView(
                padding: AppPadding.screenPadding,
                children: [
                  const LogoApp(),
                  const Gap(30),
                  if (state is VerifyCodeLoadingGetState)
                    const SpinKitFoldingCube(color: AppColor.primaryColor),
                  if (cubit.email != null)
                    Text(
                      cubit.message,
                      style: AppTextStyle.f18w500black,
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
                  Align(
                    alignment: isEnglish()
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        cubit.getVerifyCode();
                      },
                      child: Text(
                        AppText.resendVerifyCode.tr,
                        style: AppTextStyle.f16w600TextColor2,
                      ),
                    ),
                  ),
                  const Gap(25),
                  if (state is VerifyCodeLoadingState)
                    const SpinKitThreeBounce(color: AppColor.primaryColor),
                  if (state is! VerifyCodeLoadingState)
                    CustomButton(
                      onTap: cubit.verifyCode,
                      text: AppText.verify.tr,
                    ),
                  const Gap(20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
