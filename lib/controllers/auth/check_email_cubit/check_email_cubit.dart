import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';

import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/enums/status_request.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  CheckEmailCubit() : super(CheckEmailInitialState());

  static CheckEmailCubit get(BuildContext context) => BlocProvider.of(context);
  var statusRequest = StatusRequest.none;

  bool get isLoading => statusRequest == StatusRequest.loading;

  void _update(CheckEmailState state) {
    if (isClosed) return;
    emit(state);
  }

  final emPHController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool isEmail = true;

  @override
  Future<void> close() {
    emPHController.dispose();
    return super.close();
  }

  void changeIsEmail(bool isEmail) {
    if (isLoading) return;
    if (this.isEmail == isEmail) return;
    this.isEmail = isEmail;
    _update(CheckEmailChangeState());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void check() async {
    if (!formKey.currentState!.validate()) return;
    statusRequest = StatusRequest.loading;
    _update(CheckEmailLoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    final data = {
      AppRKeys.em_ph: emPHController.text,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.checkEmail(data: data);
    statusRequest = StatusRequest.none;
    response.fold((l) {
      _update(CheckEmailFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 405) {
        final message = AppText.goToTheOtherPlatform.tr;
        _update(CheckEmailFailureState(FailureState(message: message)));
      } else if (status == 403) {
        final message = AppText.userNotFound.tr;
        _update(CheckEmailFailureState(FailureState(message: message)));
      } else if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        _update(CheckEmailSuccessState());
      } else {
        _update(CheckEmailFailureState(FailureState()));
      }
    });
  }
}
