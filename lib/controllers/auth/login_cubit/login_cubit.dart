import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_local_data.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void _update(LoginState state) {
    if (isClosed) return;
    emit(state);
  }

  final emPhController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool obscureText = true;
  bool isEmail = true;

  @override
  Future<void> close() {
    emPhController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    _update(LoginChangeShowPasswordState());
  }

  void changeIsEmail(bool isEmail) {
    if (this.isEmail == isEmail) return;
    this.isEmail = isEmail;
    _update(LoginChangeState());
  }

  void login() async {
    final data = {
      AppRKeys.em_ph: emPhController.text,
      AppRKeys.role: AppConstant.pharmacist,
      AppRKeys.password: passwordController.text,
    };
    if (!formKey.currentState!.validate()) {
      return;
    }
    _update(LoginLoadingState());
    final response = await _authRemoteData.login(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(LoginFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 402) {
        final s = AppText.somethingWentWrong.tr;
        _update(LoginFailureState(FailureState(message: s)));
      } else if (response[AppRKeys.status] == 403) {
        final s = isEmail
            ? AppText.emailOrPasswordIsWrong.tr
            : AppText.phoneOrPasswordIsWrong.tr;
        _update(LoginFailureState(FailureState(message: s)));
      } else if (response[AppRKeys.status] == 404) {
        _update(LoginNotVerifyState());
      } else if (response[AppRKeys.status] == 405) {
        final state = FailureState(message: AppText.goToTheOtherPlatform.tr);
        _update(LoginFailureState(state));
      } else {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        if (AppLocalData.user!.emailVerifiedAt == null) {
          _update(LoginNotVerifyState());
        } else {
          _update(LoginSuccessState());
        }
      }
    });
  }
}
