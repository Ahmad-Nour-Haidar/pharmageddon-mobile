import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_constant.dart';
import 'package:pharmageddon_mobile/core/constant/app_keys.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';
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
    required this.enableEdit,
  });

  final OrderModel model;
  final bool enableEdit;

  @override
  State<TopWidgetOrderDetailsScreen> createState() =>
      _TopWidgetOrderDetailsScreenState();
}

class _TopWidgetOrderDetailsScreenState
    extends State<TopWidgetOrderDetailsScreen> {
  late final OrderDetailsCubit cubit;
  bool _isLoadingCancel = false;
  bool _isLoadingDone = false;
  bool _isLoadingReceived = false;

  void onTapEdit(bool value) {
    cubit.isEdit = value;
  }

  Future<void> onTapCancel() async {
    if (_isLoadingDone) return;
    setState(() => _isLoadingCancel = true);
    await cubit.cancelOrder();
    setState(() => _isLoadingCancel = false);
  }

  Future<void> onTapReceived() async {
    setState(() => _isLoadingReceived = true);
    await cubit.updateOrderStatus(AppConstant.received);
    setState(() => _isLoadingReceived = false);
  }

  Future<void> onTapDone() async {
    if (_isLoadingCancel) return;
    setState(() => _isLoadingDone = true);
    await cubit.updateOrder();
    _isLoadingDone = false;
    onTapEdit(false);
    setState(() {});
  }

  @override
  void initState() {
    cubit = OrderDetailsCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final tag = args.args[AppKeys.tag];
    return Container(
      padding: AppPadding.padding7,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: tag,
            child: Row(
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
              if (widget.model.orderStatus == OrderStatus.hasBeenSent)
                CustomTextButton(
                  isLoading: _isLoadingReceived,
                  onTap: () {
                    showAwesomeReceived(context);
                  },
                  color: AppColor.secondColor,
                  text: AppText.iReceivedIt.tr,
                  style: AppTextStyle.f18w500secondColor,
                ),
              if (widget.model.orderStatus == OrderStatus.preparing)
                CustomTextButton(
                  isLoading: _isLoadingDone,
                  onTap: () {
                    widget.enableEdit ? onTapDone() : onTapEdit(true);
                  },
                  color: AppColor.green3,
                  text: widget.enableEdit ? AppText.done.tr : AppText.edit.tr,
                  style: AppTextStyle.f18w500green3,
                ),
              if (widget.enableEdit &&
                  widget.model.orderStatus == OrderStatus.preparing)
                CustomTextButton(
                  isLoading: false,
                  onTap: () => onTapEdit(false),
                  color: AppColor.green3,
                  text: AppText.back.tr,
                  style: AppTextStyle.f18w500green3,
                ),
              if (widget.model.orderStatus == OrderStatus.preparing)
                CustomTextButton(
                  isLoading: _isLoadingCancel,
                  onTap: () {
                    showAwesomeCancel(context);
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

  void showAwesomeCancel(BuildContext context) {
    AwesomeDialog(
      context: context,
      btnOkText: AppText.ok.tr,
      btnCancelText: AppText.cancel.tr,
      title: AppText.confirmCancellation.tr,
      titleTextStyle: AppTextStyle.f18w600red,
      desc: '${AppText.cancelOrderNo.tr} ${widget.model.id}'.trn,
      descTextStyle: AppTextStyle.f18w500black,
      dialogType: DialogType.question,
      btnOkOnPress: onTapCancel,
      btnCancelOnPress: () {},
      btnOkColor: AppColor.red,
      btnCancelColor: AppColor.green,
    ).show();
  }

  void showAwesomeReceived(BuildContext context) {
    AwesomeDialog(
      context: context,
      btnOkText: AppText.yes.tr,
      btnCancelText: AppText.no.tr,
      title: AppText.confirm.tr,
      titleTextStyle: AppTextStyle.f18w500green,
      desc: AppText.areYouReallyReceivedThisOrder.tr,
      descTextStyle: AppTextStyle.f18w500black,
      dialogType: DialogType.question,
      btnOkOnPress: onTapReceived,
      btnCancelOnPress: () {},
      btnOkColor: AppColor.green,
      btnCancelColor: AppColor.red,
    ).show();
  }
}
