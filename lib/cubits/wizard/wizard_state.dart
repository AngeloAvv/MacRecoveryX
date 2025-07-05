part of 'wizard_cubit.dart';

@freezed
sealed class WizardState with _$WizardState {
  const factory WizardState({
    OS? os,
    Directory? destination,
  }) = WizardStateData;
}
