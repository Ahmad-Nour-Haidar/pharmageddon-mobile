import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controllers/search_cubit/search_cubit.dart';
import '../../controllers/search_cubit/search_state.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_strings.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
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
                buildWhen: (previous, current) {
                  return current is! SearchFailureState;
                },
                listener: (context, state) {
                  if (state is SearchFailureState) {
                    handleState(context: context, state: state.state);
                  }
                },
                builder: (context, state) {
                  final cubit = SearchCubit.get(context);
                  var s = '${AppStrings.searchResultsFor.tr} : ';
                  if (state is SearchSuccessState) s += state.value;
                  if (state is SearchNoDataState) s += state.value;
                  Widget widget = const SizedBox();
                  switch (state.runtimeType) {
                    case SearchLoadingState:
                      widget = MedicationsLoading(onRefresh: () async {});
                      break;
                    case SearchSuccessState:
                      widget = MedicationsListWidget(
                          data: cubit.medications, onRefresh: () async {});
                      break;
                    case SearchNoDataState:
                      widget =
                          AppInjection.getIt<AppWidget>().noDataAfterSearch;
                      break;
                  }
                  return Padding(
                    padding: AppPadding.screenPaddingAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(10),
                        if (state is SearchSuccessState ||
                            state is SearchNoDataState)
                          AutoSizeText(
                            s,
                            style: AppTextTheme.f18w500black,
                            maxLines: 1,
                          ),
                        const Gap(10),
                        widget,
                      ],
                    ),
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
