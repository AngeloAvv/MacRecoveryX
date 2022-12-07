import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/models/step.dart';

class StepCubit extends Cubit<Step> {
  StepCubit() : super(Step.welcome);

  void init() => emit(Step.welcome);

  void next() {
    final index = state.index + 1;

    if (index < Step.values.length) {
      emit(Step.values[index]);
    }
  }

  void prev() {
    final index = state.index - 1;

    if (index >= 0) {
      emit(Step.values[index]);
    }
  }
}
