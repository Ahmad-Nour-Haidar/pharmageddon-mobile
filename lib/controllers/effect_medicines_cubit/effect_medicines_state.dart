import '../../core/class/parent_state.dart';

abstract class EffectMedicinesState {}

class EffectMedicinesInitialState extends EffectMedicinesState {}

class EffectMedicinesLoadingState extends EffectMedicinesState {}

class EffectMedicinesSuccessState extends EffectMedicinesState {}

class EffectMedicinesFailureState extends EffectMedicinesState {
  final ParentState state;

  EffectMedicinesFailureState(this.state);
}
