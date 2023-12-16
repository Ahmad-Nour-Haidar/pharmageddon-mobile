import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_details_cubit/order_details_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/order_details_widget.dart';
import '../../controllers/order_cubit/order_cubit.dart';
import '../../controllers/order_details_cubit/order_details_state.dart';
import '../../core/constant/app_color.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/cart/table_widget.dart';
import '../widgets/top_widget_order_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final OrderModel model = args.args[AppKeys.orderModel];
    return Scaffold(
      appBar: CustomAppBar(title: AppText.orderDetails.tr).build(),
      body: BlocProvider(
        create: (context) =>
            AppInjection.getIt<OrderDetailsCubit>()..initial(model),
        child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is OrderDetailsFailureState) {
              handleState(state: state.state, context: context);
            } else if (state is OrderDetailsDeleteMedicineSuccessState) {
              handleState(state: state.state, context: context);
            } else if (state is OrderDetailsUpdateOrderSuccessState) {
              handleState(state: state.state, context: context);
            } else if (state is OrderDetailsSuccessCancelState) {
              Navigator.pop(context);
            } else if (state is OrderDetailsAllCanceledState) {
              showAwesome(context);
            }
          },
          builder: (context, state) {
            final cubit = OrderDetailsCubit.get(context);
            return Padding(
              padding: AppPadding.screenPaddingAll,
              child: Column(
                children: [
                  if (cubit.medicinesQuantityNotAvailable.isNotEmpty)
                    TableWidget(
                      data: cubit.medicinesQuantityNotAvailable,
                    ),
                  if (cubit.medicinesQuantityNotAvailable.isNotEmpty)
                    const Gap(15),
                  TopWidgetOrderDetailsScreen(
                    model: cubit.model,
                    onTapEdit: (bool isEdit) {
                      cubit.isEdit = isEdit;
                    },
                  ),
                  const Gap(10),
                  if (state is OrderDetailsLoadingDeleteMedicineState)
                    const LinearProgressIndicator(
                      color: AppColor.secondColor,
                    ),
                  if (state is OrderDetailsLoadingDeleteMedicineState)
                    const Gap(10),
                  if (state is OrderDetailsGetLoadingState) const Gap(50),
                  if (state is OrderDetailsGetLoadingState)
                    const SpinKitFoldingCube(color: AppColor.buttonColor),
                  OrderDetailsList(
                    data: cubit.data,
                    enableEdit: cubit.isEdit,
                    onEditMedicine: cubit.onEditMedicine,
                    onTapDelete: cubit.onTapDeleteMedicine,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showAwesome(BuildContext context) {
    final cubit = OrderDetailsCubit.get(context);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      desc: AppText
          .medicineHasCanceledAndOrderHasCanceledBecauseThereIsNoMedicinesInTheOrder
          .tr,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnOkOnPress: () {
        AppInjection.getIt<OrderCubit>().removeOrderFromList(cubit.model);
        Navigator.pop(context);
      },
    ).show();
  }
}
