part of 'dependency_injector.dart';

class _Repositories extends StatelessWidget {
  final Widget child;

  const _Repositories({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => FileExplorerRepository(),
          ),
          RepositoryProvider(
            create: (context) => RecoveryRepository(
              service: context.read(),
            ),
          ),
        ],
        child: child,
      );
}
