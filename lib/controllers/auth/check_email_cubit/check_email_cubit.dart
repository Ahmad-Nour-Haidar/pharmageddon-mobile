import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';
import 'check_email_state.dart';

class CheckEmailCubit extends Cubit<CheckEmailState> {
  CheckEmailCubit() : super(CheckEmailInitialState());

  static CheckEmailCubit get(BuildContext context) => BlocProvider.of(context);
  void _update(CheckEmailState state) {
    if (isClosed) return;
    emit(state);
  }
  final emPHController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool isEmail = true;

  @override
  Future<void> close() {
    emPHController.dispose();
    return super.close();
  }

  void changeIsEmail(bool isEmail) {
    if (this.isEmail == isEmail) return;
    this.isEmail = isEmail;
    _update(CheckEmailChangeState());
  }

  void check() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _update(CheckEmailLoadingState());
    final data = {
      AppRKeys.em_ph: emPHController.text,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await authRemoteData.checkEmail(data: data);
    if (isClosed) return;
    response.fold((l) {
      _update(CheckEmailFailureState(l));
    }, (response) async {
      if (response[AppRKeys.status] == 405) {
        final message = AppStrings.goToTheOtherPlatform.tr;
        _update(CheckEmailFailureState(FailureState(message: message)));
      } else if (response[AppRKeys.status] == 403) {
        final message = AppStrings.userNotFound.tr;
        _update(CheckEmailFailureState(FailureState(message: message)));
      } else {
        await storeUser(response);
        _update(CheckEmailSuccessState());
      }
    });
  }
}
