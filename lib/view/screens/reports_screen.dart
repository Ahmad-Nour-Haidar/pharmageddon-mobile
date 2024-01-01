import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/app_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/orders_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/order_widget.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../core/constant/app_color.dart';
import '../../core/resources/app_text_theme.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_pick_date_widget.dart';
import '../widgets/custom_pie_chart.dart';
import '../widgets/row_text_span.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
          if (cubit.showPieChart) {
            body = CustomPieChart(data: cubit.data);
          } else if (state is ReportsLoadingState) {
            body = OrdersLoading(onRefresh: cubit.getData);
          } else {
            body = OrderListWidget(
              data: cubit.data,
              onRefresh: cubit.getData,
              canPushNamed: false,
            );
          }
          return Scaffold(
            appBar: CustomAppBar(
              title: AppText.reports.tr,
              showPieChart: true,
              onTapPieChart: cubit.changeShowPieChart,
            ).build(),
            body: Padding(
              padding: AppPadding.screenPaddingAll,
              child: Column(
                children: [
                  CustomPickDateWidget(
                    onChange: cubit.setDateTimeRange,
                    dateTimeRange: cubit.dateTimeRange,
                  ),
                  const Gap(10),
                  Expanded(child: body),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowTextSpan(
                              s1: '${AppText.totalOrders.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: cubit.data.length.toString().trn,
                            ),
                            RowTextSpan(
                              s1: '${AppText.totalQuantity.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: cubit.totalQuantity.toString().trn,
                            ),
                            RowTextSpan(
                              s1: '${AppText.totalPrice.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 3,
                        child: state is ReportsLoadingState
                            ? const SpinKitThreeBounce(
                                color: AppColor.primaryColor,
                              )
                            : CustomButton(
                                onTap: cubit.getData,
                                text: AppText.send.tr,
                                color: AppColor.primaryColor,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
