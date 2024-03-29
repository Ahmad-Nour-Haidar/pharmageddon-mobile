import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/auth/verify_code_cubit/verify_code_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_text.dart';
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

  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();

  void initial() {
    getVerifyCode();
  }

  void onSubmit(String verificationCode) => code = verificationCode;

  String get message =>
      '${AppText.enterTheVerificationCodeYouReceivedOnGmail.tr}\n$email';

  Future<void> getVerifyCode() async {
    email = null;
    _update(VerifyCodeLoadingGetState());
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.getVerificationCode(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(VerifyCodeFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 402) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        _update(VerifyCodeFailureState(FailureState(message: message)));
      } else if (status == 405) {
        final message = AppText.verifyCodeNotSentTryAgain.tr;
        _update(VerifyCodeFailureGetState(FailureState(message: message)));
      } else if (status == 200) {
        email = AppLocalData.user!.email;
        _update(VerifyCodeSuccessGetState());
      } else {
        _update(VerifyCodeFailureState(FailureState()));
      }
    });
  }

  void verifyCode() async {
    if (code.length < 6) {
      _update(VerifyCodeFailureState(
          FailureState(message: AppText.enterTheCompleteVerificationCode.tr)));
      return;
    }
    _update(VerifyCodeLoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    final data = {
      AppRKeys.em_ph: AppLocalData.user!.email,
      AppRKeys.role: AppConstant.pharmacist,
      AppRKeys.verification_code: code,
    };
    final response = await _authRemoteData.verify(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(VerifyCodeFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 403 || status == 402) {
        final message = AppText.verifyCodeNotCorrect.tr;
        _update(VerifyCodeFailureState(FailureState(message: message)));
      } else if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        _update(VerifyCodeSuccessState());
      } else {
        _update(VerifyCodeFailureState(FailureState()));
      }
    });
  }
}
