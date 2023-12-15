import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_details_cubit/order_details_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_svg.dart';
import '../../model/order_details_model.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({
    super.key,
    required this.index,
    required this.model,
    required this.enableEdit,
    required this.onEditMedicine,
  });

  final int index;
  final OrderDetailsModel model;
  final bool enableEdit;
  final void Function(int id, int newQuantity) onEditMedicine;

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  String get name {
    return getOrderDetailsModelName(widget.model);
  }

  static Timer? _timer;
  static const _duration = Duration(milliseconds: 100);
  int quantity = 1;
  late OrderDetailsCubit cubit;

  @override
  void initState() {
    cubit = OrderDetailsCubit.get(context);
    quantity = cubit.getQuantityOfMedicine(widget.model);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OrderDetailsWidget oldWidget) {
    quantity = cubit.getQuantityOfMedicine(widget.model);
    super.didUpdateWidget(oldWidget);
  }

  void change(int x) {
    if (quantity + x < 1) return;
    if (quantity + x > 500) return;
    quantity += x;
    setState(() {});
    widget.onEditMedicine(widget.model.medicineId!, quantity);
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
              if (widget.enableEdit) const Gap(10),
              if (widget.enableEdit)
                Row(
                  children: [
                    GestureDetector(
                      onLongPress: () {
                        change(-1);
                        _timer =
                            Timer.periodic(_duration, (timer) => change(-1));
                      },
                      onLongPressEnd: (LongPressEndDetails details) {
                        _timer?.cancel();
                        _timer = null;
                      },
                      child: InkWell(
                        onTap: () => change(-1),
                        child: const Align(
                          child: SvgImage(
                            path: AppSvg.minus,
                            color: AppColor.primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: AppPadding.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColor.primaryColor),
                      ),
                      child: Text(
                        maxLines: 1,
                        quantity.toString(),
                        style: AppTextTheme.f16w600primaryColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => change(1),
                      onLongPress: () {
                        change(1);
                        _timer =
                            Timer.periodic(_duration, (timer) => change(1));
                      },
                      onLongPressEnd: (LongPressEndDetails details) {
                        _timer?.cancel();
                        _timer = null;
                      },
                      child: InkWell(
                        onTap: () => change(1),
                        child: const Align(
                          child: SvgImage(
                            path: AppSvg.plus,
                            color: AppColor.primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
                '  ( ${widget.index + 1} )  ',
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
  const OrderDetailsList({
    super.key,
    required this.data,
    required this.enableEdit,
    required this.onEditMedicine,
  });

  final List<OrderDetailsModel> data;
  final bool enableEdit;
  final void Function(int id, int newQuantity) onEditMedicine;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => OrderDetailsWidget(
          index: index,
          model: data[index],
          enableEdit: enableEdit,
          onEditMedicine: onEditMedicine,
        ),
        separatorBuilder: (context, index) => const Gap(0),
        itemCount: data.length,
      ),
    );
  }
}
