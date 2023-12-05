import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/model/manufacturer_model.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../../controllers/effect_medicines_cubit/effect_medicines_cubit.dart';
import '../../controllers/effect_medicines_cubit/effect_medicines_state.dart';
import '../../controllers/factory_medicines_cubit/factory_medicines_cubit.dart';
import '../../controllers/factory_medicines_cubit/factory_medicines_state.dart';
import '../../core/constant/app_lottie.dart';
import '../../core/constant/app_padding.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';

class FactoryMedicinesScreen extends StatelessWidget {
  const FactoryMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final ManufacturerModel model = args.args[AppKeys.factoryModel];
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AppInjection.getIt<FactoryMedicinesCubit>()..initial(model),
        child: BlocConsumer<FactoryMedicinesCubit, FactoryMedicinesState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = FactoryMedicinesCubit.get(context);
            Widget widget = const SizedBox();
            switch (state.runtimeType) {
              case FactoryMedicinesLoadingState:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
              case FactoryMedicinesFailureState:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
              case FactoryMedicinesSuccessState:
                widget = MedicationsListWidget(
                  data: cubit.medications,
                  onRefresh: () => cubit.getMedications(forceGetData: true),
                );
                break;
              // other
              case FactoryMedicinesNoDataState:
                widget = Center(child: Lottie.asset(AppLottie.noData));
                break;
              default:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
            }
            return Scaffold(
              appBar: const CustomAppBar().build(),
              body: Padding(
                padding: AppPadding.screenPadding,
                child: Column(
                  children: [widget],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
