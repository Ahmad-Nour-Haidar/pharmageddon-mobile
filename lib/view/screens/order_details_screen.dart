import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_details_cubit/order_details_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/order_details_widget.dart';
import '../../controllers/order_details_cubit/order_details_state.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/top_widget_order_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final OrderModel model = args.args[AppKeys.orderModel];
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.orderDetails.tr).build(),
      body: BlocProvider(
        create: (context) =>
            AppInjection.getIt<OrderDetailsCubit>()..initial(model),
        child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is OrderDetailsSuccessCancelState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final cubit = OrderDetailsCubit.get(context);
            return Padding(
              padding: AppPadding.screenPaddingAll,
              child: Column(
                children: [
                  TopWidgetOrderDetailsScreen(
                    model: model,
                    onTapEdit: (bool isEdit) {
                      cubit.isEdit = isEdit;
                    },
                    totalPrice: cubit.totalPrice,
                    totalQuantity: cubit.totalQuantity,
                  ),
                  const Gap(10),
                  OrderDetailsList(
                    data: cubit.data,
                    enableEdit: cubit.isEdit,
                    onEditMedicine: cubit.onEditMedicine,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
