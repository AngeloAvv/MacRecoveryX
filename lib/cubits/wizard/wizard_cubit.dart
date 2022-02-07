import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:macrecovery_x/models/os.dart';

part 'wizard_cubit.g.dart';
part 'wizard_state.dart';

class WizardCubit extends Cubit<WizardState> {
  WizardCubit() : super(const WizardState());

  void os(OS os) => emit(state.copyWith(os: os));

  void destination(Directory destination) =>
      emit(state.copyWith(destination: destination));
}
