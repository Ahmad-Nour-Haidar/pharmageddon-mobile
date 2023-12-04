import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../../controllers/factory_medicines_cubit/effect_medicines_state.dart';
import '../../controllers/medication_details_cubit/medication_details_cubit.dart';
import '../../core/constant/app_keys.dart';
import '../../core/constant/app_padding.dart';
import '../../model/screen_arguments.dart';
import '../widgets/custom_button.dart';
import '../widgets/medication_details/counter_widget.dart';
import '../widgets/medication_details/medication_image.dart';
import '../widgets/row_text.dart';
import '../widgets/row_text_span.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final medicationId = args.args[AppKeys.medicationModel];
    return BlocProvider(
      create: (context) =>
          AppInjection.getIt<MedicationDetailsCubit>()..initial(medicationId),
      child: BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = MedicationDetailsCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.medicationDetails.tr,
            ).build(),
            drawer: const Drawer(),
            endDrawer: const Drawer(),
            body: ListView(
              padding: AppPadding.screenPaddingAll,
              children: [
                const MedicationImage(),
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
                            s2: '${AppStrings.scientificName.tr} ${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}: ',
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.commercialName.tr} : ',
                            s2: '${AppStrings.scientificName.tr} ${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}${AppStrings.scientificName.tr}: ',
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.description.tr} : ',
                            s2: 'AppStrings.description.tr AppStrings.description.tr AppStrings.description.tr AppStrings.description.tr AppStrings.description.tr AppStrings.description.tr ',
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.availableQuantity.tr} : ',
                            s2: '15',
                          ),
                          const Gap(5),
                          RowText(
                            s1: '${AppStrings.expirationDate.tr} : ',
                            s2: '2001 - 8 - 16',
                            textDirection: TextDirection.ltr,
                          ),
                          const Gap(5),
                          RowTextSpan(
                            s1: '${AppStrings.price.tr} : ',
                            s2: '250 S.P',
                          ),
                          const Gap(15),
                          RowTextSpan(
                            s1: '${AppStrings.totalPrice.tr} : ',
                            ts1: AppTextTheme.f18w600red,
                            s2: '${cubit.q * 250} S.P',
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
                                onTap: () {},
                                text: 'Add to cart',
                                height: 40,
                                width: AppSize.width / 2,
                              ),
                            ),
                          const Gap(10),
                        ],
                      ),
                    ),
                    CounterWidget(
                      initialValue: cubit.q,
                      maxValue: 100,
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
