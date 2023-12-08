import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/auth/verify_code_cubit/verify_code_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitialState());

  void _update(VerifyCodeState state) {
    if (isClosed) return;
    emit(state);
  }

  static VerifyCodeCubit get(BuildContext context) => BlocProvider.of(context);
  late String code = '';
  String? email;

  final authRemoteData = AppInjection.getIt<AuthRemoteData>();

  void initial() {
    getVerifyCode();
  }

  void onSubmit(String verificationCode) {
    code = verificationCode;
  }

  String get message =>
      '${AppStrings.enterTheVerificationCodeYouReceivedOnGmail.tr}\n$email';

  void getVerifyCode() async {
    email = null;
    _update(VerifyCodeLoadingGetState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await authRemoteData.getVerificationCode(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(VerifyCodeFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final message = AppStrings.verifyCodeNotSentTryAgain.tr;
        _update(VerifyCodeFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 405) {
        final message = AppStrings.verifyCodeNotSentTryAgain.tr;
        _update(VerifyCodeFailureGetState(FailureState(message: message)));
      } else {
        email = AppLocalData.user!.email;
        _update(VerifyCodeSuccessGetState());
      }
    });
  }

  void verifyCode() async {
    if (code.length < 6) {
      _update(VerifyCodeFailureState(FailureState(
          message: AppStrings.enterTheCompleteVerificationCode.tr)));
      return;
    }
    _update(VerifyCodeLoadingState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.pharmacist,
      AppRKeys.verification_code: code,
    };
    final response = await authRemoteData.verify(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(VerifyCodeFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 403 ||
          response[AppRKeys.status] == 402) {
        final message = AppStrings.verifyCodeNotCorrect.tr;
        _update(VerifyCodeFailureState(FailureState(message: message)));
      } else {
        await storeUser(response);
        _update(VerifyCodeSuccessState());
      }
    });
  }
}
