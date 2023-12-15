import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';

import 'app_widget.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.model,
    required this.canPushNamed,
  });

  final OrderModel model;
  final bool canPushNamed;

  String get paymentStatus {
    return model.paymentStatus == 0 ? AppText.unpaid.tr : AppText.paid.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: InkWell(
        onTap: !canPushNamed
            ? null
            : () => pushNamed(AppRoute.ordersDetails, context,
                arguments: {AppKeys.orderModel: model}),
        child: Padding(
          padding: AppPadding.padding10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RowTextSpan(
                    s1: '${AppText.id.tr} : ',
                    s2: model.id.toString(),
                  ),
                  const Spacer(),
                  AppInjection.getIt<AppWidget>().getOrderIcon(model),
                  const Gap(10),
                ],
              ),
              RowTextSpan(
                s1: '${AppText.totalQuantity.tr} : ',
                s2: model.totalQuantity.toString(),
              ),
              RowTextSpan(
                s1: '${AppText.totalPrice.tr} : ',
                s2: model.totalPrice.toString(),
              ),
              RowTextSpan(
                s1: '${AppText.paymentState.tr} : ',
                s2: paymentStatus,
              ),
              RowTextSpan(
                s1: '${AppText.date.tr} : ',
                s2: formatYYYYMd(model.createdAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
    required this.data,
    required this.onRefresh,
    required this.canPushNamed,
  });

  final List<OrderModel> data;
  final Future<void> Function() onRefresh;
  final bool canPushNamed;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: data.isEmpty
          ? ListView(
              children: [AppInjection.getIt<AppWidget>().noData],
            )
          : ListView.separated(
              padding: AppPadding.screenPaddingAll,
              itemBuilder: (context, index) => OrderWidget(
                model: data[index],
                canPushNamed: canPushNamed,
              ),
              separatorBuilder: (context, index) => const Gap(10),
              itemCount: data.length,
            ),
    );
  }
}
