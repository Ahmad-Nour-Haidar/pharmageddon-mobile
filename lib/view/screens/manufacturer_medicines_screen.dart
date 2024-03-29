import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';

import '../../controllers/manufacturer_medicines_cubit/manufacturer_medicines_cubit.dart';
import '../../controllers/manufacturer_medicines_cubit/manufacturer_medicines_state.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_size.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';

class ManufacturerMedicinesScreen extends StatelessWidget {
  const ManufacturerMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final ManufacturerModel model = args.args[AppKeys.manufacturerModel];
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AppInjection.getIt<ManufacturerMedicinesCubit>()..initial(model),
        child: BlocConsumer<ManufacturerMedicinesCubit,
            ManufacturerMedicinesState>(
          buildWhen: (previous, current) {
            return current is! FactoryMedicinesFailureState;
          },
          listener: (context, state) {
            if (state is FactoryMedicinesFailureState) {
              handleState(state: state.state, context: context);
            }
          },
          builder: (context, state) {
            final cubit = ManufacturerMedicinesCubit.get(context);
            Widget widget = MedicationsLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
            if (state is FactoryMedicinesSuccessState) {
              widget = MedicationsListWidget(
                onEmpty: null,
                data: cubit.medications,
                onRefresh: () => cubit.getMedications(forceGetData: true),
              );
            }
            return Scaffold(
              appBar: CustomAppBar(
                title: getManufacturerName(cubit.model),
              ).build(),
              body: Padding(
                padding: AppPadding.screenPadding,
                child: Column(
                  children: [widget, const Gap(AppSize.screenPadding)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
