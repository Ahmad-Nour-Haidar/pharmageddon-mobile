import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_lottie.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/home/effect_category_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/home/manufacturers_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/manufacturers_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/medications_loading.dart';
import '../widgets/Custom_nav_bar.dart';
import '../widgets/loading/effect_category_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
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
        switch (state.runtimeType) {
          // 1
          case HomeGetMedicationsLoadingState:
            widget = MedicationsLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
            break;
          case HomeGetMedicationsFailureState:
            widget = MedicationsLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
            break;
          case HomeGetMedicationsSuccessState:
            widget = MedicationsListWidget(
                onRefresh: () => cubit.getMedications(forceGetData: true));
            break;
          // 2
          case HomeGetFactoriesLoadingState:
            widget = ManufacturersLoading(
                onRefresh: () => cubit.getFactories(forceGetData: true));
            break;
          case HomeGetFactoriesFailureState:
            widget = ManufacturersLoading(
                onRefresh: () => cubit.getFactories(forceGetData: true));
            break;
          case HomeGetFactoriesSuccessState:
            widget = ManufacturersListWidget(
                onRefresh: () => cubit.getFactories(forceGetData: true));
            break;
          // 3
          case HomeGetEffectCategoriesLoadingState:
            widget = EffectCategoryLoading(
                onRefresh: () => cubit.getEffectCategories(forceGetData: true));
            break;
          case HomeGetEffectCategoriesFailureState:
            widget = EffectCategoryLoading(
                onRefresh: () => cubit.getEffectCategories(forceGetData: true));
            break;
          case HomeGetEffectCategoriesSuccessState:
            widget = EffectCategoriesListWidget(
                onRefresh: () => cubit.getEffectCategories(forceGetData: true));
            break;
          // other
          case HomeNoDataState:
            widget = Center(child: Lottie.asset(AppLottie.noData));
            break;
          default:
            widget = MedicationsLoading(
                onRefresh: () => cubit.getMedications(forceGetData: true));
            break;
        }
        return Scaffold(
          key: scaffoldKey,
          bottomNavigationBar: CustomNavBar(
            onChange: cubit.changeScreen,
            list: AppConstant.homeList,
            initialIndex: cubit.indexScreen,
          ),
          appBar: CustomAppBar(
            keyScaffold: scaffoldKey,
            title: cubit.title,
            showArrowBack: false,
            showSearch: true,
            showOptionsLeading: true,
            onTapSearch: () => pushNamed(AppRoute.search, context),
          ).build(),
          drawer: const Drawer(),
          body: Padding(
            padding: AppPadding.screenPadding,
            child: Column(children: [widget]),
          ),
        );
      },
    );
  }
}
