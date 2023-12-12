import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_details_cubit/order_details_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/enums/order_status.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../../controllers/order_details_cubit/order_details_state.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
import '../widgets/cancel_button.dart';
import '../widgets/row_text_span.dart';

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
                  Container(
                    padding: AppPadding.padding7,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RowTextSpan(
                              s1: '${AppStrings.id.tr} : ',
                              s2: model.id.toString(),
                              ts1: AppTextTheme.f18w600black,
                              ts2: AppTextTheme.f18w400black,
                            ),
                            AppInjection.getIt<AppWidget>().getOrderIcon(model),
                          ],
                        ),
                        RowTextSpan(
                          s1: '${AppStrings.totalQuantity.tr} : ',
                          s2: model.totalQ.toString(),
                          ts1: AppTextTheme.f18w600black,
                          ts2: AppTextTheme.f18w400black,
                        ),
                        RowTextSpan(
                          s1: '${AppStrings.totalPrice.tr} : ',
                          s2: model.totalP.toString(),
                          ts1: AppTextTheme.f18w600black,
                          ts2: AppTextTheme.f18w400black,
                        ),
                        RowTextSpan(
                          s1: '${AppStrings.paymentState.tr} : ',
                          s2: model.payment.toString(),
                          ts1: AppTextTheme.f18w600black,
                          ts2: AppTextTheme.f18w400black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RowTextSpan(
                              s1: '${AppStrings.date.tr} : ',
                              s2: formatYYYYMdEEEE(model.date),
                              ts1: AppTextTheme.f18w600black,
                              ts2: AppTextTheme.f18w400black,
                            ),
                            CancelButton(
                              isShow: model.status == OrderStatus.preparing,
                              isLoading:
                                  state is OrderDetailsLoadingCancelState,
                              onTap: cubit.cancel,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.primaryColor,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
