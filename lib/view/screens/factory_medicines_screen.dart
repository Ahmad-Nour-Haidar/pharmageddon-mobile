import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/effect_medicines_cubit/factory_medicines_cubit.dart';
import '../../controllers/effect_medicines_cubit/factory_medicines_state.dart';
import '../../core/services/dependency_injection.dart';

class FactoryMedicinesScreen extends StatelessWidget {
  const FactoryMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppInjection.getIt<FactoryMedicinesCubit>(),
        child: BlocConsumer<FactoryMedicinesCubit, FactoryMedicinesState>(
          listener: (context, state) {},
          builder: (context, state) {
            return const Center(
              child: Text('Name of your screen'),
            );
          },
        ),
      ),
    );
  }
}
