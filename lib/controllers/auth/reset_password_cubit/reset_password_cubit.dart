import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void _update(ResetPasswordState state) {
    if (isClosed) return;
    emit(state);
  }

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  final formKey = GlobalKey<FormState>();
  late String code = '';
  String? email;
  bool obscureText = true;

  void initial() async {
    getVerifyCode();
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    _update(ResetPasswordChangeShowPasswordState());
  }

  String get message =>
      '${AppStrings.enterTheVerificationCodeYouReceivedOnGmail.tr}\n$email';

  void onSubmit(String verificationCode) {
    code = verificationCode;
  }

  void getVerifyCode() async {
    email = null;
    _update(ResetPasswordLoadingGetState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.getVerificationCode(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(ResetPasswordFailureGetState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final message = AppStrings.verifyCodeNotSentTryAgain.tr;
        _update(ResetPasswordFailureGetState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 405) {
        final message = AppStrings.verifyCodeNotSentTryAgain.tr;
        _update(ResetPasswordFailureGetState(FailureState(message: message)));
      } else {
        email = AppLocalData.user!.email;
        _update(ResetPasswordSuccessGetState());
      }
    });
  }

  void reset() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (code.length < 6) {
      _update(ResetPasswordFailureState(FailureState(
          message: AppStrings.enterTheCompleteVerificationCode.tr)));
      return;
    }
    if (passwordController.text != confirmController.text) {
      _update(ResetPasswordFailureState(
          FailureState(message: AppStrings.passwordsNoMatch.tr)));
      return;
    }
    _update(ResetPasswordLoadingState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.password: passwordController.text,
      AppRKeys.verification_code: code,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.resetPassword(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(ResetPasswordFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final message = AppStrings.somethingWentWrong.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 403) {
        final message = AppStrings.verifyCodeNotCorrect.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 405) {
        final message = AppStrings.goToTheOtherPlatform.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        _update(ResetPasswordSuccessState());
      }
    });
  }
}
