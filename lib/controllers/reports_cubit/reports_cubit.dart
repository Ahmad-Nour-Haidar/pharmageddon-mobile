import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_mobile/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../data/remote/reports_data.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitialState());

  static ReportsCubit get(BuildContext context) => BlocProvider.of(context);
  final _reportsRemoteData = AppInjection.getIt<ReportsRemoteData>();
  var dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  void _update(ReportsState state) {
    if (isClosed) return;
    emit(state);
  }

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    this.dateTimeRange = dateTimeRange;
    printme.yellow(dateTimeRange);
    _update(ReportsChangeState());
  }

  Future<void> getData(String value) async {}
}
