import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/enums/status_request.dart';
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
  var statusRequest = StatusRequest.none;

  bool get isLoading => statusRequest == StatusRequest.loading;

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
      '${AppText.enterTheVerificationCodeYouReceivedOnGmail.tr}\n$email';

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
      final status = response[AppRKeys.status];
      if (status == 402) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        _update(ResetPasswordFailureGetState(FailureState(message: message)));
      } else if (status == 405) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        _update(ResetPasswordFailureGetState(FailureState(message: message)));
      } else if (status == 200) {
        email = AppLocalData.user!.email;
        _update(ResetPasswordSuccessGetState());
      } else {
        _update(ResetPasswordFailureGetState(FailureState()));
      }
    });
  }

  void reset() async {
    if (!formKey.currentState!.validate()) return;
    if (code.length < 6) {
      _update(ResetPasswordFailureState(
          FailureState(message: AppText.enterTheCompleteVerificationCode.tr)));
      return;
    }
    if (passwordController.text != confirmController.text) {
      _update(ResetPasswordFailureState(
          FailureState(message: AppText.passwordsNoMatch.tr)));
      return;
    }
    statusRequest = StatusRequest.loading;
    _update(ResetPasswordLoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.password: passwordController.text,
      AppRKeys.verification_code: code,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.resetPassword(data: data);
    statusRequest = StatusRequest.none;
    response.fold((l) {
      _update(ResetPasswordFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 402) {
        final message = AppText.somethingWentWrong.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else if (status == 403) {
        final message = AppText.verifyCodeNotCorrect.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else if (status == 405) {
        final message = AppText.goToTheOtherPlatform.tr;
        _update(ResetPasswordFailureState(FailureState(message: message)));
      } else if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        _update(ResetPasswordSuccessState());
      } else {
        _update(ResetPasswordFailureGetState(FailureState()));
      }
    });
  }
}
