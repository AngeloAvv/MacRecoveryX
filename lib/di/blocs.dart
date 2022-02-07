part of 'dependency_injector.dart';

class _Blocs extends StatelessWidget {
  final Widget child;

  const _Blocs({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<WizardCubit>(create: (_) => WizardCubit()),
          BlocProvider<StepCubit>(create: (_) => StepCubit()),
        ],
        child: child,
      );
}
