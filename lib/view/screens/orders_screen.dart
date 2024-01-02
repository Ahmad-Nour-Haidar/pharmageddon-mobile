import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_cubit/order_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_nav_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/orders_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/order/order_widget.dart';

import '../../controllers/order_cubit/order_state.dart';
import '../../core/services/dependency_injection.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppInjection.getIt<OrderCubit>().initial();
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = OrderCubit.get(context);
        final body = state is OrderLoadingState
            ? OrdersLoading(
                onRefresh: () async => cubit.getAll(forceGetData: true))
            : OrderListWidget(
                data: cubit.data,
                onRefresh: () async => cubit.getAll(forceGetData: true),
                canPushNamed: true,
              );
        return Scaffold(
          appBar: CustomAppBar(
            title: cubit.currentScreen.titleScreen.tr,
          ).build(),
          bottomNavigationBar: CustomNavBar(
            onChange: cubit.changeScreen,
            list: AppConstant.ordersList,
            initialScreen: cubit.currentScreen,
          ),
          body: Padding(
            padding: AppPadding.screenPaddingNoTop,
            child: body,
          ),
        );
      },
    );
  }
}
