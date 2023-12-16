import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';

import '../../controllers/medication_details_cubit/medication_details_cubit.dart';
import '../../controllers/medication_details_cubit/medication_details_state.dart';
import '../../core/constant/app_keys.dart';
import '../../core/constant/app_padding.dart';
import '../../model/medication_model.dart';
import '../../model/screen_arguments.dart';
import '../widgets/custom_button.dart';
import '../widgets/medication_details/counter_widget.dart';
import '../widgets/medication_details/medication_image.dart';
import '../widgets/row_text_span.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final MedicationModel model = args.args[AppKeys.medicationModel];
    return BlocProvider(
      create: (context) =>
          AppInjection.getIt<MedicationDetailsCubit>()..initial(model),
      child: BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
        listener: (context, state) {
          if (state is MedicationDetailsFailureState) {
            handleState(state: state.state, context: context);
          } else if (state is MedicationDetailsSuccessState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = MedicationDetailsCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: AppText.medicationDetails.tr,
            ).build(),
            body: ListView(
              padding: AppPadding.screenPaddingAll,
              children: [
                MedicationImage(
                  isFav: cubit.model.isFavourite!,
                  onTapFav: cubit.onTapFav,
                ),
                const Gap(30),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: AppPadding.only(top: 20),
                      padding: AppPadding.padding10,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(30),
                          RowTextSpan(
                            s1: '${AppText.scientificName.tr} : ',
                            s2: getMedicationScientificName(cubit.model),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.commercialName.tr} : ',
                            s2: getMCommercialName(cubit.model),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.manufacturer.tr} : ',
                            s2: getManufacturerName(cubit.model.manufacturer),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.effect.tr} : ',
                            s2: getEffectCategoryModelName(
                                cubit.model.effectCategory),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.description.tr} : ',
                            s2: getMedicationModelDescription(cubit.model).trn,
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.availableQuantity.tr} : ',
                            s2: cubit.model.availableQuantity.toString().trn,
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppText.price.tr} : ',
                            s2: '${cubit.model.price} ${AppText.sp.tr}'.trn,
                          ),
                          if (cubit.model.discount! > 0)
                            RowTextSpan(
                              s1: '${AppText.discount.tr} : ',
                              s2: '${cubit.model.discount} %'.trn,
                            ),
                          if (cubit.model.discount! > 0)
                            RowTextSpan(
                              s1: '${AppText.priceAfterDiscount.tr} : ',
                              s2: '${cubit.model.priceAfterDiscount} ${AppText.sp.tr}'
                                  .trn,
                            ),
                          RowTextSpan(
                            s1: '${AppText.expirationDate.tr} : ',
                            s2: formatYYYYMd(cubit.model.expirationDate),
                          ),
                          const Gap(15),
                          RowTextSpan(
                            s1: '${AppText.totalPrice.tr} : ',
                            ts1: AppTextStyle.f18w600red,
                            s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                            ts2: AppTextStyle.f18w400red,
                          ),
                          const Gap(30),
                          if (state is MedicationDetailsLoadingState)
                            const SpinKitThreeBounce(
                                color: AppColor.buttonColor),
                          if (state is! MedicationDetailsLoadingState)
                            Center(
                              child: CustomButton(
                                onTap: cubit.addToCart,
                                text: AppText.saveInCart.tr,
                                height: 40,
                                width: AppSize.width / 2,
                              ),
                            ),
                          const Gap(10),
                        ],
                      ),
                    ),
                    CounterWidget(
                      initialValue: cubit.quantity,
                      maxValue: cubit.model.availableQuantity ?? 0,
                      onChange: cubit.changeQuantity,
                    ),
                  ],
                ),
                const Gap(25),
              ],
            ),
          );
        },
      ),
    );
  }
}
