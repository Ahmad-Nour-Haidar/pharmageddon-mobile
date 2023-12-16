import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import '../../controllers/order_details_cubit/order_details_cubit.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/enums/order_status.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';
import 'app_widget.dart';
import 'custom_text_button.dart';

class TopWidgetOrderDetailsScreen extends StatefulWidget {
  const TopWidgetOrderDetailsScreen({
    super.key,
    required this.model,
    required this.onTapEdit,
  });

  final OrderModel model;
  final void Function(bool isEdit) onTapEdit;

  @override
  State<TopWidgetOrderDetailsScreen> createState() =>
      _TopWidgetOrderDetailsScreenState();
}

class _TopWidgetOrderDetailsScreenState
    extends State<TopWidgetOrderDetailsScreen> {
  late final OrderDetailsCubit cubit;
  bool _isLoadingCancel = false;
  bool _isLoadingDone = false;
  bool _isEdit = false;

  void onTapEdit(bool value) {
    setState(() {
      _isEdit = value;
    });
    widget.onTapEdit(_isEdit);
  }

  Future<void> onTapCancel() async {
    if (_isLoadingDone) return;
    setState(() => _isLoadingCancel = true);
    await cubit.cancel();
    setState(() => _isLoadingCancel = false);
  }

  Future<void> onTapDone() async {
    if (_isLoadingCancel) return;
    setState(() => _isLoadingDone = true);
    _isLoadingDone = await cubit.update();
    if (!_isLoadingDone) _isEdit = false;
    setState(() {});
    widget.onTapEdit(_isEdit);
  }

  @override
  void initState() {
    cubit = OrderDetailsCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                s1: '${AppText.id.tr} : ',
                s2: widget.model.id.toString().trn,
                ts1: AppTextStyle.f18w600black,
                ts2: AppTextStyle.f18w400black,
              ),
              AppInjection.getIt<AppWidget>().getOrderIcon(widget.model),
            ],
          ),
          RowTextSpan(
            s1: '${AppText.totalQuantity.tr} : ',
            s2: widget.model.totalQuantity.toString().trn,
            ts1: AppTextStyle.f18w600black,
            ts2: AppTextStyle.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppText.totalPrice.tr} : ',
            s2: '${widget.model.totalPrice} ${AppText.sp.tr}'.trn,
            ts1: AppTextStyle.f18w600black,
            ts2: AppTextStyle.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppText.paymentState.tr} : ',
            s2: getPaymentStatus(widget.model),
            ts1: AppTextStyle.f18w600black,
            ts2: AppTextStyle.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppText.date.tr} : ',
            s2: formatYYYYMdEEEE(widget.model.createdAt),
            ts1: AppTextStyle.f18w600black,
            ts2: AppTextStyle.f18w400black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextButton(
                isShow: widget.model.orderStatus == OrderStatus.preparing,
                isLoading: _isLoadingDone,
                onTap: () => _isEdit ? onTapDone : onTapEdit(true),
                color: AppColor.green3,
                text: _isEdit ? AppText.done.tr : AppText.edit.tr,
                style: AppTextStyle.f18w500green3,
              ),
              if (_isEdit)
                CustomTextButton(
                  isShow: widget.model.orderStatus == OrderStatus.preparing,
                  isLoading: false,
                  onTap: () => onTapEdit(false),
                  color: AppColor.green3,
                  text: AppText.back.tr,
                  style: AppTextStyle.f18w500green3,
                ),
              CustomTextButton(
                isShow: widget.model.orderStatus == OrderStatus.preparing,
                isLoading: _isLoadingCancel,
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    btnOkText: AppText.ok.tr,
                    btnCancelText: AppText.cancel.tr,
                    title: AppText.confirmCancellation.tr,
                    titleTextStyle: AppTextStyle.f18w600red,
                    desc: '${AppText.cancelOrderNo.tr} ${widget.model.id}',
                    descTextStyle: AppTextStyle.f18w500black,
                    dialogType: DialogType.error,
                    btnOkOnPress: onTapCancel,
                    btnCancelOnPress: () {},
                    btnOkColor: AppColor.red,
                    btnCancelColor: AppColor.green,
                  ).show();
                },
                color: AppColor.red,
                text: AppText.cancel.tr,
                style: AppTextStyle.f18w500red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
