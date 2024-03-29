import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/auth/register_cubit/register_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import '../../../core/class/parent_state.dart';
import '../../../core/constant/app_request_keys.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/enums/status_request.dart';
import '../../../core/functions/check_errors.dart';
import '../../../core/functions/functions.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../data/remote/auth_data.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  void _update(RegisterState state) {
    if (isClosed) return;
    emit(state);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  bool obscureText = true;
  var statusRequest = StatusRequest.none;

  bool get isLoading => statusRequest == StatusRequest.loading;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    userNameController.dispose();
    addressController.dispose();
    return super.close();
  }

  void showPassword() {
    obscureText = !obscureText;
    _update(RegisterChangeShowPasswordState());
  }

  void register() async {
    if (!formKey.currentState!.validate()) return;
    statusRequest = StatusRequest.loading;
    _update(RegisterLoadingState());
    FocusManager.instance.primaryFocus?.unfocus();
    final data = {
      AppRKeys.email: emailController.text,
      AppRKeys.username: userNameController.text,
      AppRKeys.phone: phoneController.text,
      AppRKeys.password: passwordController.text,
      AppRKeys.address: addressController.text,
      AppRKeys.role: AppConstant.pharmacist,
    };
    final response = await _authRemoteData.register(data: data);
    statusRequest = StatusRequest.none;
    response.fold((l) {
      _update(RegisterFailureState(l));
    }, (response) async {
      final status = response[AppRKeys.status];
      if (status == 400) {
        var s = checkErrorMessages(
            response[AppRKeys.message][AppRKeys.validation_errors]);
        s = '${AppText.field.tr} $s ${AppText.alreadyBeenTaken.tr}';
        _update(RegisterFailureState(FailureState(message: s)));
      } else if (status == 200) {
        await storeUser(response[AppRKeys.data][AppRKeys.user]);
        _update(RegisterSuccessState());
      } else {
        _update(RegisterFailureState(FailureState()));
      }
    });
  }
}
