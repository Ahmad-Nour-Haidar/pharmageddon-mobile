import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/cart_cubit/cart_cubit.dart';
import 'package:pharmageddon_mobile/controllers/cart_cubit/cart_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_button.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/row_text_span.dart';

import '../widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.cart.tr,
        showSearch: true,
      ).build(),
      body: BlocProvider(
        create: (context) => AppInjection.getIt<CartCubit>()..initial(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartFailureState) {
              handleState(state: state.state, context: context);
            }
          },
          builder: (context, state) {
            final cubit = CartCubit.get(context);
            return Padding(
              padding: AppPadding.screenPaddingAll,
              child: Column(
                children: [
                  Expanded(
                    child: CartWidgetList(
                      data: cubit.data,
                      onTapRemove: cubit.onTapRemove,
                      onChange: cubit.changeQuantityOfModel,
                    ),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowTextSpan(
                              s1: '${AppStrings.totalMedications.tr} : ',
                              ts1: AppTextTheme.f15w600black,
                              s2: cubit.data.length.toString(),
                            ),
                            RowTextSpan(
                              s1: '${AppStrings.totalQuantity.tr} : ',
                              ts1: AppTextTheme.f15w600black,
                              s2: cubit.totalQuantity.toString(),
                            ),
                            RowTextSpan(
                              s1: '${AppStrings.totalPrice.tr} : ',
                              ts1: AppTextTheme.f15w600black,
                              s2: '${cubit.totalPrice} ${AppStrings.sp.tr}',
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        flex: 3,
                        child: state is CartLoadingState
                            ? const SpinKitThreeBounce(
                                color: AppColor.buttonColor,
                              )
                            : CustomButton(
                                onTap: cubit.order,
                                text: AppStrings.order.tr,
                                color: AppColor.primaryColor,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
