import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_mobile/controllers/search_cubit/search_cubit.dart';
import 'package:pharmageddon_mobile/controllers/search_cubit/search_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_lottie.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';
import 'package:pharmageddon_mobile/view/widgets/handle_state.dart';
import 'package:pharmageddon_mobile/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_mobile/view/widgets/loading/medications_loading.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../../core/constant/app_svg.dart';

class CustomSearch extends SearchDelegate {
  @override
  String? get searchFieldLabel => AppStrings.search.tr;

  @override
  Widget buildResults(BuildContext context) {
    printme.cyan(query);
    printme.magenta(query.isEmpty);
    if (query.isEmpty) return text;
    return BlocProvider(
      create: (context) => AppInjection.getIt<SearchCubit>()..search(query),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchFailureState) {
            handleState(context: context, state: state.state);
          }
        },
        builder: (context, state) {
          final cubit = SearchCubit.get(context);
          Widget body = Column(children: [
            MedicationsLoading(onRefresh: () async {}),
          ]);
          if (state is SearchFailureState) {
            body = Center(child: Lottie.asset(AppLottie.somethingWentWrong));
          }
          if (state is SearchSuccessState && cubit.data.isEmpty) {
            final s = '${AppStrings.searchResultsFor.tr} : ${state.value}';
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  s,
                  style: AppTextTheme.f18w500black,
                  maxLines: 1,
                ),
                Lottie.asset(AppLottie.noDataAfterSearch),
              ],
            );
          }
          if (state is SearchSuccessState && cubit.data.isNotEmpty) {
            final s = '${AppStrings.searchResultsFor.tr} : ${state.value}';
            body = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  s,
                  style: AppTextTheme.f18w500black,
                  maxLines: 1,
                ),
                const Gap(10),
                MedicationsListWidget(onRefresh: () async {}),
              ],
            );
          }
          return Padding(
            padding: AppPadding.screenPaddingAll,
            child: body,
          );
        },
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const SvgImage(
          path: AppSvg.close,
          color: AppColor.black,
          size: 26,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: SvgImage(
        path: isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight,
        color: AppColor.black,
        size: 26,
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: AppColor.white.withOpacity(.65),
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      scaffoldBackgroundColor: AppColor.background,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  final text = Center(
    child: Text(
      AppStrings.typeSomethingToSearchOnIt.tr,
      style: AppTextTheme.f20w600black,
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    return text;
  }
}
