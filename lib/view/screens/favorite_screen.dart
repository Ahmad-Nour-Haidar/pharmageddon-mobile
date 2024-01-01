import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/app_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';

import '../../controllers/favorite_cubit/favorite_cubit.dart';
import '../../controllers/favorite_cubit/favorite_state.dart';
import '../../core/constant/app_padding.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = FavoriteCubit.get(context);
    cubit.getFavorites(forceGetData: true);
    return Scaffold(
      appBar: CustomAppBar(
        title: AppText.favorite.tr,
        showSearch: true,
      ).build(),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        buildWhen: (previous, current) {
          return current is! FavoriteFailureState;
        },
        listener: (context, state) {
          if (state is FavoriteFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          Widget widget = const SizedBox();
          switch (state.runtimeType) {
            case FavoriteLoadingState:
              widget = MedicationsLoading(
                  onRefresh: () => cubit.getFavorites(forceGetData: true));
              break;
            case FavoriteSuccessState:
              widget = MedicationsListWidget(
                data: cubit.medications,
                onRefresh: () => cubit.getFavorites(forceGetData: true),
              );
              break;
            case FavoriteNoDataState:
              widget = Expanded(child: AppInjection.getIt<AppWidget>().addFav);
              break;
          }
          return Padding(
            padding: AppPadding.screenPadding,
            child: Column(children: [widget]),
          );
        },
      ),
    );
  }
}
