import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/home/effect_category_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/home/manufacturers_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/manufacturers_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/medications_loading.dart';

import '../../core/constant/app_local_data.dart';
import '../../core/enums/screens.dart';
import '../widgets/back_button_wrapper.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/loading/effect_category_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    printme.cyan(AppLocalData.user?.authorization);
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is! HomeGetFailureState;
      },
      listener: (context, state) {
        if (state is HomeGetFailureState) {
          handleState(context: context, state: state.state);
        }
      },
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        Widget widget = const SizedBox();
        // 1
        if (cubit.currentScreen == ScreenShow.medications) {
          widget = MedicationsListWidget(
              data: cubit.medications,
              onRefresh: () => cubit.getMedications(forceGetData: true));
          if (state is HomeGetMedicationsLoadingState) {
            widget = MedicationsLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
          }
        }
        if (cubit.currentScreen == ScreenShow.discount) {
          widget = MedicationsListWidget(
              data: cubit.discountsData,
              onRefresh: () => cubit.getDiscounts(forceGetData: true));
          if (state is HomeGetDiscountsLoadingState) {
            widget = MedicationsLoading(
                onRefresh: () => cubit.getDiscounts(forceGetData: true));
          }
        }
        // 2
        if (cubit.currentScreen == ScreenShow.manufacturer) {
          widget = ManufacturersListWidget(
              data: cubit.manufacturers,
              onRefresh: () => cubit.getManufacturers(forceGetData: true));
          if (state is HomeGetManufacturersLoadingState) {
            widget = ManufacturersLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
          }
        }
        // 3
        if (cubit.currentScreen == ScreenShow.effect) {
          widget = EffectCategoriesListWidget(
              data: cubit.effectCategories,
              onRefresh: () => cubit.getManufacturers(forceGetData: true));
          if (state is HomeGetEffectCategoriesLoadingState) {
            widget = EffectCategoryLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
          }
        }
        return BackButtonWrapper(
          child: Scaffold(
            bottomNavigationBar: CustomNavBar(
              initialScreen: cubit.currentScreen,
              list: AppConstant.homeList,
              onChange: cubit.changeScreen,
            ),
            appBar: CustomAppBar(
              title: cubit.currentScreen.titleScreen.tr,
              showArrowBack: false,
              showSearch: true,
              showOptions: true,
              showCart: true,
              showFavorites: true,
              showOrders: true,
              showReports: true,
            ).build(),
            body: Padding(
              padding: AppPadding.screenPadding,
              child: Column(children: [widget]),
            ),
          ),
        );
      },
    );
  }
}
