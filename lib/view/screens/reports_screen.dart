import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/app_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/orders_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/order_widget.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../core/constant/app_color.dart';
import '../../core/resources/app_text_theme.dart';
import '../widgets/Custom_pick_data_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/row_text_span.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.reports.tr).build(),
      body: BlocProvider(
        create: (context) => AppInjection.getIt<ReportsCubit>(),
        child: BlocConsumer<ReportsCubit, ReportsState>(
          listener: (context, state) {
            if (state is ReportsFailureState) {
              handleState(state: state.state, context: context);
            }
          },
          builder: (context, state) {
            final cubit = ReportsCubit.get(context);
            Widget body = AppInjection.getIt<AppWidget>().reports;
            if (state is ReportsSuccessState || cubit.data.isNotEmpty) {
              body = OrderListWidget(
                data: cubit.data,
                onRefresh: () => cubit.getData(),
                canPushNamed: false,
              );
            }
            if (state is ReportsLoadingState) {
              body = OrdersLoading(onRefresh: () => cubit.getData());
            }
            return Column(
              children: [
                CustomPickDataWidget(
                  onChange: cubit.setDateTimeRange,
                  dateTimeRange: cubit.dateTimeRange,
                ),
                const Gap(10),
                Expanded(child: body),
                const Gap(10),
                Row(
                  children: [
                    const Gap(15),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowTextSpan(
                            s1: '${AppStrings.totalOrders.tr} : ',
                            ts1: AppTextTheme.f15w600black,
                            s2: cubit.data.length.toString(),
                          ),
                          RowTextSpan(
                            s1: '${AppStrings.totalQuantity.tr} : ',
                            ts1: AppTextTheme.f15w600black,
                            s2: cubit.totalQuantity.toString(),
                          ),
                          RowTextSpan(
                            s1: '${AppStrings.totalPrice.tr} : ',
                            ts1: AppTextTheme.f15w600black,
                            s2: '${cubit.totalPrice} ${AppStrings.sp.tr}',
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      flex: 3,
                      child: state is ReportsLoadingState
                          ? const SpinKitThreeBounce(
                              color: AppColor.buttonColor,
                            )
                          : CustomButton(
                              onTap: () => cubit.getData(),
                              text: AppStrings.send.tr,
                              color: AppColor.primaryColor,
                            ),
                    ),
                    const Gap(15),
                  ],
                ),
                const Gap(15),
              ],
            );
          },
        ),
      ),
    );
  }
}
