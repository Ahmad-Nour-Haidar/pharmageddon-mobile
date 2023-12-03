import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../widgets/Custom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          bottomNavigationBar: CustomNavBar(
            onChange: cubit.changeScreen,
            list: AppConstant.homeList,
            initialIndex: cubit.indexScreen,
          ),
          appBar: CustomAppBar(
            title: cubit.title,
            showArrowBack: false,
            showSearch: true,
            showOptionsLeading: true,
            // onTapSearch: () => showSearch(context: context, delegate: CustomSearch()),
            onTapSearch: () => pushNamed(AppRoute.search, context),
            onTapOptions: () => scaffoldKey.currentState!.openDrawer(),
          ).build(),
          drawer: const Drawer(),
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
