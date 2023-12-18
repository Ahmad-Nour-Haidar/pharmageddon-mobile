import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/order_details_cubit/order_details_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
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
    required this.onTapDelete,
  });

  final int index;
  final OrderDetailsModel model;
  final bool enableEdit;
  final void Function(int id, int newQuantity) onEditMedicine;
  final void Function(int id) onTapDelete;

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
    if (quantity + x > 200) return;
    quantity += x;
    setState(() {});
    widget.onEditMedicine(widget.model.medicineId!, quantity);
  }

  double get totalPrice {
    if (!widget.enableEdit) return widget.model.totalPrice!;
    var x = widget.model.priceWhenOrdered! * quantity;
    x -= (x * widget.model.hasDiscount! / 100);
    return x;
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
              RowTextSpan(s1: '${AppText.name.tr} : ', s2: name),
              RowTextSpan(
                s1: '${AppText.totalQuantity.tr} : ',
                s2: widget.model.totalQuantity.toString().trn,
              ),
              RowTextSpan(
                s1: '${AppText.totalPrice.tr} : ',
                s2: '$totalPrice ${AppText.sp.tr}'.trn,
              ),
              if (widget.enableEdit)
                RowTextSpan(
                  s1: '${AppText.priceWhenOrdered.tr} : ',
                  s2: '${widget.model.priceWhenOrdered} ${AppText.sp.tr}'.trn,
                ),
              if (widget.enableEdit)
                RowTextSpan(
                  s1: '${AppText.discount.tr} : ',
                  s2: '${widget.model.hasDiscount} % '.trn,
                ),
              if (widget.enableEdit) const Gap(5),
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
                        quantity.toString().trn,
                        style: AppTextStyle.f16w600primaryColor,
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
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showAwesomeDeleteMedicine(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgImage(
                          path: AppSvg.trash,
                          color: AppColor.green2,
                          size: 20,
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
                '  ( ${widget.index + 1} )  '.trn,
                style: AppTextStyle.f20w600green2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showAwesomeDeleteMedicine(BuildContext context) {
    AwesomeDialog(
      context: context,
      btnOkText: AppText.ok.tr,
      btnCancelText: AppText.cancel.tr,
      title: AppText.confirmDeletion.tr,
      titleTextStyle: AppTextStyle.f18w600red,
      desc: name,
      descTextStyle: AppTextStyle.f18w500black,
      dialogType: DialogType.question,
      btnOkOnPress: () {
        widget.onTapDelete(widget.model.medicineId!);
      },
      btnCancelOnPress: () {},
      btnOkColor: AppColor.red,
      btnCancelColor: AppColor.green,
    ).show();
  }
}

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList({
    super.key,
    required this.data,
    required this.enableEdit,
    required this.onEditMedicine,
    required this.onTapDelete,
  });

  final List<OrderDetailsModel> data;
  final bool enableEdit;
  final void Function(int id, int newQuantity) onEditMedicine;
  final void Function(int id) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => OrderDetailsWidget(
          index: index,
          model: data[index],
          enableEdit: enableEdit,
          onEditMedicine: onEditMedicine,
          onTapDelete: onTapDelete,
        ),
        separatorBuilder: (context, index) => const Gap(0),
        itemCount: data.length,
      ),
    );
  }
}
