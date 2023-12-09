import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';

import '../../controllers/effect_medicines_cubit/effect_medicines_cubit.dart';
import '../../controllers/effect_medicines_cubit/effect_medicines_state.dart';
import '../../core/constant/app_keys.dart';
import '../../core/constant/app_lottie.dart';
import '../../core/constant/app_padding.dart';
import '../../model/effect_category_model.dart';
import '../../model/screen_arguments.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';

class EffectMedicinesScreen extends StatelessWidget {
  const EffectMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final EffectCategoryModel model = args.args[AppKeys.effectModel];
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AppInjection.getIt<EffectMedicinesCubit>()..initial(model),
        child: BlocConsumer<EffectMedicinesCubit, EffectMedicinesState>(
          buildWhen: (previous, current) {
            return current is! EffectMedicinesFailureState;
          },
          listener: (context, state) {
            if (state is EffectMedicinesFailureState) {
              handleState(state: state.state, context: context);
            }
          },
          builder: (context, state) {
            final cubit = EffectMedicinesCubit.get(context);
            Widget widget = const SizedBox();
            switch (state.runtimeType) {
              case EffectMedicinesLoadingState:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
              case EffectMedicinesFailureState:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
              case EffectMedicinesSuccessState:
                widget = MedicationsListWidget(
                  data: cubit.medications,
                  onRefresh: () => cubit.getMedications(forceGetData: true),
                );
                break;
              // other
              case EffectMedicinesNoDataState:
                widget = Center(child: Lottie.asset(AppLottie.noData));
                break;
              default:
                widget = MedicationsLoading(
                    onRefresh: () => cubit.getMedications(forceGetData: true));
                break;
            }
            return Scaffold(
              appBar: CustomAppBar(title: getEffectCategoryModelName(model))
                  .build(),
              body: Padding(
                padding: AppPadding.screenPaddingAll,
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
