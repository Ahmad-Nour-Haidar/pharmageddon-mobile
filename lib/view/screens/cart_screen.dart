import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/cart_cubit/cart_cubit.dart';
import 'package:pharmageddon_mobile/controllers/cart_cubit/cart_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_text.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_button.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';

import '../widgets/cart/cart_widget.dart';
import '../widgets/cart/table_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppText.cart.tr,
        showSearch: true,
      ).build(),
      body: BlocProvider(
        create: (context) => AppInjection.getIt<CartCubit>()..initial(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartFailureState) {
              handleState(state: state.state, context: context);
            }
            if (state is CartSuccessState) {
              handleState(state: state.state, context: context);
            }
          },
          builder: (context, state) {
            final cubit = CartCubit.get(context);
            return Padding(
              padding: AppPadding.screenPadding,
              child: Column(
                children: [
                  if (cubit.dataNotAvailable.isNotEmpty)
                    TableWidget(data: cubit.dataNotAvailable),
                  if (cubit.dataNotAvailable.isNotEmpty) const Gap(15),
                  CartWidgetList(
                    data: cubit.data,
                    onTapRemove: cubit.onTapRemove,
                    onChange: cubit.changeQuantityOfModel,
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowTextSpan(
                              s1: '${AppText.totalMedications.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: cubit.data.length.toString().trn,
                            ),
                            RowTextSpan(
                              s1: '${AppText.totalQuantity.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: cubit.totalQuantity.toString().trn,
                            ),
                            RowTextSpan(
                              s1: '${AppText.totalPrice.tr} : ',
                              ts1: AppTextStyle.f15w600black,
                              s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 3,
                        child: state is CartLoadingState
                            ? const SpinKitThreeBounce(
                                color: AppColor.buttonColor)
                            : CustomButton(
                                onTap: cubit.createOrder,
                                text: AppText.order.tr,
                                color: AppColor.primaryColor,
                              ),
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
