import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../widgets/Custom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppInjection.getIt<HomeCubit>();
        return Scaffold(
          bottomNavigationBar: CustomNavBar(
            onChange: cubit.changeScreen,
            list: AppConstant.homeList,
            initialIndex: cubit.indexScreen,
          ),
          appBar: CustomAppBar(
            title: AppStrings.home.tr,
            showArrowBack: false,
            showSearch: true,
            onTapSearch: () => pushNamed(AppRoute.search, context),
          ).build(),
          body: Padding(
            padding: AppPadding.screenPadding,
            child: Column(
              children: [
                cubit.screen,
              ],
            ),
          ),
        );
      },
    );
  }
}
