import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/models/step.dart';

class StepCubit extends Cubit<Step> {
  StepCubit() : super(Step.welcome());

  void init() => emit(Step.welcome());

  void next() {
    final currentIndex = state.number;
    final step = Step.values[currentIndex].call();
    emit(step);
  }

  void prev() {
    final currentIndex = state.number;
    final step = Step.values[currentIndex - 2].call();
    emit(step);
  }
}
