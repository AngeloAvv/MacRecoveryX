part of 'wizard_cubit.dart';

@freezed
class WizardState with _$WizardState {
  const factory WizardState({
    OS? os,
    Directory? destination,
  }) = _WizardState;
}
