import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/local/cart_quantity_data.dart';
import '../../model/cart_model.dart';
import 'counter_Cart_widget.dart';
import 'custom_cached_network_image.dart';

class CartWidgetList extends StatelessWidget {
  const CartWidgetList({
    super.key,
    required this.data,
    required this.onTapRemove,
    required this.onChange,
  });

  final List<CartModel> data;
  final void Function() onTapRemove;
  final void Function() onChange;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (context, index) => const Gap(15),
      itemBuilder: (context, index) => CartWidget(
        model: data[index],
        onTapRemove: onTapRemove,
        onChange: onChange,
      ),
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.model,
    required this.onTapRemove,
    required this.onChange,
  });

  final void Function() onTapRemove;
  final void Function() onChange;
  final CartModel model;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  static final _cartQuantityData = AppInjection.getIt<CartQuantityData>();

  void changeQuantity(int x) {
    if (widget.model.quantity + x < 0) return;
    if (widget.model.quantity + x >
        widget.model.medicationModel.availableQuantity!) return;
    widget.model.quantity += x;
    try {
      _cartQuantityData.storeInCart(
        widget.model.medicationModel.id,
        widget.model.quantity,
      );
      setState(() {
        widget.onChange();
      });
    } catch (e) {
      printme.red(e);
    }
  }

  void removeFromCart() {
    try {
      _cartQuantityData.storeInCart(widget.model.medicationModel.id, 0);
      setState(() {});
    } catch (e) {
      printme.red(e);
    }
    widget.onTapRemove();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCachedNetworkImage(
          width: (AppSize.width * .3).toInt() - 25,
          height: 100,
          imageUrl: getUrlImageMedication(widget.model.medicationModel),
          errorWidget: ErrorWidgetShow.picture,
        ),
        const Gap(10),
        Container(
          padding: AppPadding.padding10,
          width: AppSize.width * .7 - 15,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowTextSpan(
                s1: '${AppStrings.name.tr} : ',
                s2: getMedicationCommercialName(
                  widget.model.medicationModel,
                ),
              ),
              RowTextSpan(
                s1: '${AppStrings.availableQuantity.tr} : ',
                s2: '${widget.model.medicationModel.availableQuantity}',
              ),
              RowTextSpan(
                s1: '${AppStrings.price.tr} : ',
                s2: '${widget.model.medicationModel.priceAfterDiscount}',
              ),
              RowTextSpan(
                s1: '${AppStrings.quantity.tr} : ',
                s2: '${widget.model.quantity}',
              ),
              RowTextSpan(
                s1: '${AppStrings.totalPrice.tr} : ',
                s2: '${widget.model.totalPrice}',
              ),
              const Gap(5),
              Row(
                children: [
                  CounterCartWidget(
                    onChange: changeQuantity,
                    value: widget.model.quantity,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: removeFromCart,
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
