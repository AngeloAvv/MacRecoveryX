import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';
import 'package:macrecovery_x/models/os.dart';

class OSCubit extends Cubit<OS?> {
  final WizardCubit wizardCubit;

  OSCubit({required this.wizardCubit}) : super(null);

  void toggle(OS os) => emit(state == os ? null : os);

  @override
  void onChange(Change<OS?> change) {
    super.onChange(change);

    if (change.nextState != null) {
      wizardCubit.os(change.nextState!);
    }
  }
}
