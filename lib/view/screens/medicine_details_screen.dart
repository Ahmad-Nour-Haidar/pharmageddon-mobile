import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
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
        buildWhen: (previous, current) {
          return current is! MedicationDetailsFailureState;
        },
        listener: (context, state) {
          if (state is MedicationDetailsFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = MedicationDetailsCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.medicationDetails.tr,
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
                            s1: '${AppStrings.scientificName.tr} : ',
                            s2: getMedicationScientificName(cubit.model),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.commercialName.tr} : ',
                            s2: getMedicationCommercialName(cubit.model),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.manufacturer.tr} : ',
                            s2: getManufacturerName(cubit.model.manufacturer),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.effect.tr} : ',
                            s2: getEffectCategoryModelName(
                                cubit.model.effectCategory),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.description.tr} : ',
                            s2: getMedicationModelDescription(cubit.model),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.availableQuantity.tr} : ',
                            s2: cubit.model.availableQuantity.toString(),
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.price.tr} : ',
                            s2: '${cubit.model.price} ${AppStrings.sp.tr}',
                          ),
                          if (cubit.model.discount! > 0)
                            RowTextSpan(
                              s1: '${AppStrings.discount.tr} : ',
                              s2: '${cubit.model.discount} %',
                            ),
                          if (cubit.model.discount! > 0)
                            RowTextSpan(
                              s1: '${AppStrings.priceAfterDiscount.tr} : ',
                              s2: '${cubit.model.priceAfterDiscount} ${AppStrings.sp.tr}',
                            ),
                          RowTextSpan(
                            s1: '${AppStrings.expirationDate.tr} : ',
                            s2: formatExpirationDate(
                                cubit.model.expirationDate),
                          ),
                          const Gap(5),
                          const Gap(15),
                          RowTextSpan(
                            s1: '${AppStrings.totalPrice.tr} : ',
                            ts1: AppTextTheme.f18w600red,
                            s2: '${cubit.totalPrice} ${AppStrings.sp.tr}',
                            ts2: AppTextTheme.f18w400red,
                          ),
                          const Gap(30),
                          if (state is MedicationDetailsLoadingState)
                            const SpinKitThreeBounce(
                              color: AppColor.buttonColor,
                            ),
                          if (state is! MedicationDetailsLoadingState)
                            Center(
                              child: CustomButton(
                                onTap: cubit.addToCart,
                                text: AppStrings.addToCart.tr,
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
