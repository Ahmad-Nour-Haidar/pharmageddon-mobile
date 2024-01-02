import '../../core/class/parent_state.dart';

abstract class ManufacturerMedicinesState {}

class FactoryMedicinesInitialState extends ManufacturerMedicinesState {}

class FactoryMedicinesLoadingState extends ManufacturerMedicinesState {}

class FactoryMedicinesSuccessState extends ManufacturerMedicinesState {}

class FactoryMedicinesFailureState extends ManufacturerMedicinesState {
  final ParentState state;

  FactoryMedicinesFailureState(this.state);
}
