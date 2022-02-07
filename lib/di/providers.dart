part of 'dependency_injector.dart';

class _Providers extends StatelessWidget {
  final Widget child;

  const _Providers({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => RecoveryService()),
        ],
        child: child,
      );
}
