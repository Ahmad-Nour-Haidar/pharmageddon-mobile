import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/search_cubit/search_cubit.dart';
import '../../controllers/search_cubit/search_state.dart';
import '../../core/constant/app_lottie.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/handle_state.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';
import '../widgets/search_text_field_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<SearchCubit>(),
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
              child: Builder(builder: (context) {
                final cubit = SearchCubit.get(context);
                return SearchTextFieldWidget(
                  onSubmitted: (value) {
                    if (value.isEmpty) return;
                    cubit.search(value);
                  },
                );
              }),
            ),
            Expanded(
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
                    body = Center(
                        child: Lottie.asset(AppLottie.somethingWentWrong));
                  }
                  if (state is SearchSuccessState && cubit.data.isEmpty) {
                    final s =
                        '${AppStrings.searchResultsFor.tr} : ${state.value}';
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
                    final s =
                        '${AppStrings.searchResultsFor.tr} : ${state.value}';
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
            )
          ],
        ),
      ),
    );
  }
}
