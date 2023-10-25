part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<WizardCubit>(create: (_) => WizardCubit()),
  BlocProvider<StepCubit>(create: (_) => StepCubit()),
];
