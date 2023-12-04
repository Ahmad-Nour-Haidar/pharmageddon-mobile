import '../../core/class/parent_state.dart';

abstract class FactoryMedicinesState {}

class FactoryMedicinesInitialState extends FactoryMedicinesState {}

class FactoryMedicinesLoadingState extends FactoryMedicinesState {}

class FactoryMedicinesSuccessState extends FactoryMedicinesState {}

class FactoryMedicinesFailureState extends FactoryMedicinesState {
  final ParentState state;

  FactoryMedicinesFailureState(this.state);
}
