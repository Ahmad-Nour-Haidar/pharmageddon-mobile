import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_cubit/order_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_nav_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/orders_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/order_widget.dart';

import '../../controllers/order_cubit/order_state.dart';
import '../../core/services/dependency_injection.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<OrderCubit>()..initial(),
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OrderCubit.get(context);
          final body = state is OrderSuccessState
              ? OrderListWidget(
                  data: cubit.data,
                  onRefresh: () => cubit.getData(forceGetData: true),
                )
              : OrdersLoading(
                  onRefresh: () => cubit.getData(forceGetData: true));
          return Scaffold(
            appBar: CustomAppBar(title: cubit.title.tr).build(),
            bottomNavigationBar: CustomNavBar(
              onChange: (index) => cubit.indexScreen = index,
              list: AppConstant.ordersList,
              initialIndex: cubit.indexScreen,
            ),
            body: body,
          );
        },
      ),
    );
  }
}
