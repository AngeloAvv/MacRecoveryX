import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';

class FolderCubit extends Cubit<Directory?> {
  final WizardCubit wizardCubit;

  FolderCubit({required this.wizardCubit}) : super(null);

  void select(Directory directory) => emit(directory);

  @override
  void onChange(Change<Directory?> change) {
    super.onChange(change);

    if (change.nextState != null) {
      wizardCubit.destination(change.nextState!);
    }
  }
}
