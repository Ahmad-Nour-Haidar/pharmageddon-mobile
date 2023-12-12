import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/controllers/reports_cubit/reports_state.dart';
import 'package:pharmageddon_mobile/core/class/parent_state.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/print.dart';

import '../../core/enums/order_status.dart';
import '../../data/remote/reports_data.dart';
import '../../model/order_model.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitialState());

  static ReportsCubit get(BuildContext context) => BlocProvider.of(context);
  final _reportsRemoteData = AppInjection.getIt<ReportsRemoteData>();
  final List<OrderModel> data = [];
  var dateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  void _update(ReportsState state) {
    if (isClosed) return;
    emit(state);
  }

  Future<void> getData() async {
    if (dateTimeRange.duration.inDays == 0) {
      _update(ReportsFailureState(
          FailureState(message: AppStrings.pleaseSelectStartAndEndOfDate.tr)));
      return;
    }
    List<OrderModel> temp = [
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.preparing),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
      OrderModel(OrderStatus.hasBeenSent),
    ];
    _update(ReportsLoadingState());
    final response = await _reportsRemoteData.getReports(queryParameters: {});
    response.fold((l) {
      _update(ReportsFailureState(l));
    }, (r) {
      data.clear();
      data.addAll(temp);
      _update(ReportsSuccessState());
    });
  }

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    this.dateTimeRange = dateTimeRange;
    printme.yellow(dateTimeRange);
    _update(ReportsChangeState());
  }

  int get totalQuantity {
    int q = 0;
    for (final element in data) {
      q += element.totalQ;
    }
    return q;
  }

  double get totalPrice {
    double p = 0.0;
    for (final element in data) {
      p += element.totalP;
    }
    return p;
  }
}
