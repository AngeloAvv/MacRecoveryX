import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macrecovery_x/models/os.dart';

part 'wizard_cubit.freezed.dart';
part 'wizard_state.dart';

class WizardCubit extends Cubit<WizardState> {
  WizardCubit() : super(const WizardState());

  void os(OS os) => emit(state.copyWith(os: os));

  void destination(Directory destination) =>
      emit(state.copyWith(destination: destination));
}
