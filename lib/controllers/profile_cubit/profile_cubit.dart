import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/controllers/profile_cubit/profile_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_local_data.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/auth_data.dart';
import 'package:pharmageddon_mobile/data/remote/search_data.dart';
import 'package:pharmageddon_mobile/model/medication_model.dart';
import '../../core/constant/app_request_keys.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  File? _image;

  void initial() {
    phoneController.text = AppLocalData.user!.phone!;
    nameController.text = AppLocalData.user!.username!;
    addressController.text = AppLocalData.user!.address!;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    nameController.dispose();
    addressController.dispose();
    return super.close();
  }

  void _update(ProfileState state) {
    if (isClosed) return;
    emit(state);
  }
}
