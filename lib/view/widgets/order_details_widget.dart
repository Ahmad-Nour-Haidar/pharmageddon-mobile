import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';

import '../../model/order_details_model.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({
    super.key,
    required this.index,
    required this.model,
    required this.enableEdit,
  });

  final int index;
  final OrderDetailsModel model;
  final bool enableEdit;

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  String get name {
    return getOrderDetailsModelName(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: double.infinity,
          padding: AppPadding.padding7,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.white, width: 4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowTextSpan(s1: '${AppStrings.name.tr} : ', s2: name),
              RowTextSpan(
                s1: '${AppStrings.totalQuantity.tr} : ',
                s2: widget.model.totalQuantity.toString(),
              ),
              RowTextSpan(
                s1: '${AppStrings.totalPrice.tr} : ',
                s2: '${widget.model.totalPrice} ${AppStrings.sp.tr}',
              ),
              if (widget.enableEdit)
                RowTextSpan(
                  s1: '${AppStrings.priceWhenOrdered.tr} : ',
                  s2: '${widget.model.priceWhenOrdered} ${AppStrings.sp.tr}',
                ),
              if (widget.enableEdit)
                RowTextSpan(
                  s1: '${AppStrings.discount.tr} : ',
                  s2: widget.model.hasDiscount.toString(),
                ),
            ],
          ),
        ),
        Positioned.fill(
          top: 7,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: AppColor.background,
              child: Text(
                '( ${widget.index + 1} )',
                style: AppTextTheme.f20w600green2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList(
      {super.key, required this.data, required this.enableEdit});

  final List<OrderDetailsModel> data;
  final bool enableEdit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => OrderDetailsWidget(
          index: index,
          model: data[index],
          enableEdit: enableEdit,
        ),
        separatorBuilder: (context, index) => const Gap(0),
        itemCount: data.length,
      ),
    );
  }
}
