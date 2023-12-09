import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/enums/order_status.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/model/order_model.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_svg.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.model,
  });

  final OrderModel model;

  static const _s = 20.0;

  Widget get _widget {
    late Widget widget;
    if (model.status == OrderStatus.preparing) {
      widget = const SvgImage(
        path: AppSvg.timePast,
        color: AppColor.red,
        size: _s,
      );
    } else if (model.status == OrderStatus.hasBeenSent) {
      widget = const SvgImage(
        path: AppSvg.shippingFast,
        color: AppColor.blue,
        size: _s,
      );
    } else {
      widget = const SvgImage(
        path: AppSvg.checkCircle,
        color: AppColor.green,
        size: _s,
      );
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: Padding(
        padding: AppPadding.padding10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RowTextSpan(
                  s1: '${AppStrings.id.tr} : ',
                  s2: model.id.toString(),
                ),
                const Spacer(),
                _widget,
                const Gap(10),
              ],
            ),
            RowTextSpan(
              s1: '${AppStrings.totalQuantity.tr} : ',
              s2: model.totalQ.toString(),
            ),
            RowTextSpan(
              s1: '${AppStrings.totalPrice.tr} : ',
              s2: model.totalP.toString(),
            ),
            RowTextSpan(
              s1: '${AppStrings.paymentState.tr} : ',
              s2: model.payment.toString(),
            ),
            RowTextSpan(
              s1: '${AppStrings.date.tr} : ',
              s2: formatYYYYMdEEEE(model.date),
            ),
          ],
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
  });

  final List<OrderModel> data;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: AppPadding.screenPaddingAll,
        itemBuilder: (context, index) => OrderWidget(model: data[index]),
        separatorBuilder: (context, index) => const Gap(10),
        itemCount: data.length,
      ),
    );
  }
}
