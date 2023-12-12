import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import '../../controllers/order_details_cubit/order_details_cubit.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_keys.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/enums/order_status.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/order_model.dart';
import '../../model/screen_arguments.dart';
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

  void onTapEdit() {
    setState(() {
      _isEdit = true;
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
    _isLoadingDone = await cubit.edit();
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
                s1: '${AppStrings.id.tr} : ',
                s2: widget.model.id.toString(),
                ts1: AppTextTheme.f18w600black,
                ts2: AppTextTheme.f18w400black,
              ),
              AppInjection.getIt<AppWidget>().getOrderIcon(widget.model),
            ],
          ),
          RowTextSpan(
            s1: '${AppStrings.totalQuantity.tr} : ',
            s2: widget.model.totalQ.toString(),
            ts1: AppTextTheme.f18w600black,
            ts2: AppTextTheme.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppStrings.totalPrice.tr} : ',
            s2: '${widget.model.totalP} ${AppStrings.sp.tr}',
            ts1: AppTextTheme.f18w600black,
            ts2: AppTextTheme.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppStrings.paymentState.tr} : ',
            s2: widget.model.payment.toString(),
            ts1: AppTextTheme.f18w600black,
            ts2: AppTextTheme.f18w400black,
          ),
          RowTextSpan(
            s1: '${AppStrings.date.tr} : ',
            s2: formatYYYYMdEEEE(widget.model.date),
            ts1: AppTextTheme.f18w600black,
            ts2: AppTextTheme.f18w400black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextButton(
                isShow: widget.model.status == OrderStatus.preparing,
                isLoading: _isLoadingDone,
                onTap: _isEdit ? onTapDone : onTapEdit,
                color: AppColor.green3,
                text: _isEdit ? AppStrings.done.tr : AppStrings.edit.tr,
                style: AppTextTheme.f18w500green3,
              ),
              CustomTextButton(
                isShow: widget.model.status == OrderStatus.preparing,
                isLoading: _isLoadingCancel,
                onTap: onTapCancel,
                color: AppColor.red,
                text: AppStrings.cancel.tr,
                style: AppTextTheme.f18w500red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
