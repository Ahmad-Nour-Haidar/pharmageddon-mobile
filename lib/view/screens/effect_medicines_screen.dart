import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/controllers/medication_details_cubit/medication_details_state.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import '../../controllers/factory_medicines_cubit/effect_medicines_cubit.dart';
import '../../core/constant/app_keys.dart';
import '../../model/screen_arguments.dart';

class EffectMedicinesScreen extends StatelessWidget {
  const EffectMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final tag = args.args[AppKeys.tag];
    final effectModel = args.args[AppKeys.effectModel];
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppInjection.getIt<EffectMedicinesCubit>(),
        child: BlocConsumer<EffectMedicinesCubit, EffectMedicinesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return const Center(
              child: Text('Name of your screen'),
            );
          },
        ),
      ),
    );
  }
}
