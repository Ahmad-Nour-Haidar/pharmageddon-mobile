import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_cubit/order_cubit.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';

import '../../controllers/order_cubit/order_state.dart';
import '../../core/services/dependency_injection.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context) => AppInjection.getIt<OrderCubit>(),
            child: BlocConsumer<OrderCubit, OrderState>(
              listener: (context, state) {},
              builder: (context, state) {
                final cubit  = OrderCubit.get(context);
                return  Scaffold(
                  appBar: CustomAppBar(title: cubit.title.tr).build(),
                      body: Center(
                        child: Text('name'),
                      ),
                    );
              },
            ),
          );
  }
}
