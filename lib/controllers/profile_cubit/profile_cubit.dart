import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/profile_cubit/profile_state.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/auth_data.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_cached_network_image.dart';
import '../../core/class/image_helper.dart';
import '../../core/constant/app_request_keys.dart';
import '../../core/constant/app_size.dart';
import '../../core/functions/functions.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  final _imageHelper = AppInjection.getIt<ImageHelper>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  File? _image;
  bool enableEdit = false;

  void _update(ProfileState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    emailController.text = AppLocalData.user!.email!;
    phoneController.text = AppLocalData.user!.phone!;
    nameController.text = AppLocalData.user!.username!;
    addressController.text = AppLocalData.user!.address!;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
    addressController.dispose();
    return super.close();
  }

  Future<void> updateUser() async {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    _update(ProfileLoadingState());
    final data = {
      AppRKeys.username: nameController.text,
      AppRKeys.phone: phoneController.text,
      AppRKeys.address: addressController.text,
    };
    final response = await _authRemoteData.update(data: data, file: _image);
    response.fold((l) {
      _update(ProfileFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status != 200) {
        _update(ProfileFailureState(FailureState()));
        return;
      }
      _image = null;
      enableEdit = false;
      await storeUser(r[AppRKeys.data][AppRKeys.user]);
      _update(ProfileSuccessState(
          SuccessState(message: AppText.updatedSuccessfully.tr)));
    });
  }

  void onTapEdit() {
    enableEdit = !enableEdit;
    if (!enableEdit) {
      _image = null;
    }
    _update(ProfileChangeState());
  }

  Widget get imageWidget {
    final radius = AppSize.width * .75 / 2;
    final widthHeight = 2 * radius;
    if (_image != null) {
      return Image.file(
        _image!,
        width: widthHeight,
        height: widthHeight,
        // fit: BoxFit.fill,
      );
    }
    return CustomCachedNetworkImage(
      width: widthHeight,
      height: widthHeight,
      imageUrl: getImageUserUrl(),
      errorWidget: ErrorWidgetShow.user,
    );
  }

  Future<void> pickImage() async {
    try {
      final temp = await _imageHelper.pickImage();
      if (temp == null) return;
      final tempCrop = await _imageHelper.cropImage(file: temp);
      if (tempCrop == null) return;
      _image = File(tempCrop.path);
    } catch (e) {
      printme.red(e);
    }
    _update(ProfileChangeState());
  }
}
