part of 'wizard_cubit.dart';

@CopyWith()
class WizardState extends Equatable {
  final OS? os;
  final Directory? destination;

  const WizardState({
    this.os,
    this.destination,
  });

  @override
  List<Object?> get props => [os, destination];
}
