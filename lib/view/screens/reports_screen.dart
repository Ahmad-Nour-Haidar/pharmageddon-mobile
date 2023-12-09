import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';

import '../../controllers/reports_cubit/reports_cubit.dart';
import '../widgets/Custom_pick_data_widget.dart';
import '../widgets/custom_app_bar.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.reports.tr).build(),
      body: BlocProvider(
        create: (context) => AppInjection.getIt<ReportsCubit>(),
        child: BlocConsumer<ReportsCubit, ReportsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = ReportsCubit.get(context);
            return Padding(
              padding: AppPadding.screenPaddingAll,
              child: Column(
                children: [
                  CustomPickDataWidget(
                    onChange: cubit.setDateTimeRange,
                    dateTimeRange: cubit.dateTimeRange,
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
