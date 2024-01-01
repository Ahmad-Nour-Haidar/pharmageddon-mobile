import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/app_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../model/cart_model.dart';
import '../custom_cached_network_image.dart';
import 'counter_cart_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.onTapRemove,
    required this.onChange,
    required this.model,
  });

  final void Function(int? id) onTapRemove;
  final void Function(int? id, int newQuantity) onChange;
  final CartModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomCachedNetworkImage(
            width: 200,
            height: 85,
            radius: 10,
            imageUrl: getUrlImageMedication(model.medicationModel),
            errorWidget: ErrorWidgetShow.picture,
          ),
        ),
        const Gap(10),
        Container(
          padding: AppPadding.padding7,
          width: AppSize.width * .7,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowTextSpan(
                s1: '${AppText.name.tr} : ',
                s2: getMCommercialName(
                  model.medicationModel,
                ),
              ),
              // RowTextSpan(
              //   s1: '${AppStrings.availableQuantity.tr} : ',
              //   s2: '${model.medicationModel.availableQuantity}',
              // ),
              RowTextSpan(
                s1: '${AppText.price.tr} : ',
                s2: '${model.medicationModel.priceAfterDiscount}'.trn,
              ),
              RowTextSpan(
                s1: '${AppText.quantity.tr} : ',
                s2: '${model.quantity}'.trn,
              ),
              RowTextSpan(
                s1: '${AppText.totalPrice.tr} : ',
                s2: '${model.totalPrice}'.trn,
              ),
              // const Gap(5),
              Row(
                children: [
                  CounterCartWidget(
                    onChange: (newQuantity) {
                      onChange(
                        model.medicationModel.id,
                        newQuantity,
                      );
                    },
                    initialValue: model.quantity,
                    maxValue: model.medicationModel.availableQuantity!,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        btnOkText: AppText.ok.tr,
                        btnCancelText: AppText.cancel.tr,
                        title: AppText.confirmDeletion.tr,
                        titleTextStyle: AppTextStyle.f18w600red,
                        desc: getMCommercialName(model.medicationModel),
                        descTextStyle: AppTextStyle.f18w500black,
                        dialogType: DialogType.question,
                        btnOkOnPress: () {
                          onTapRemove(model.medicationModel.id);
                        },
                        btnCancelOnPress: () {},
                        btnOkColor: AppColor.red,
                        btnCancelColor: AppColor.green,
                      ).show();
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
      ],
    );
  }
}

class CartWidgetList extends StatelessWidget {
  const CartWidgetList({
    super.key,
    required this.data,
    required this.onTapRemove,
    required this.onChange,
  });

  final List<CartModel> data;
  final void Function(int? id) onTapRemove;
  final void Function(int? id, int newQuantity) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: data.isEmpty
          ? AppInjection.getIt<AppWidget>().noData
          : ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const Gap(15),
              itemBuilder: (context, index) => CartWidget(
                model: data[index],
                onTapRemove: onTapRemove,
                onChange: onChange,
              ),
            ),
    );
  }
}
