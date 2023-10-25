part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<FileExplorerRepository>(
    create: (_) => FileExplorerRepository(),
  ),
  RepositoryProvider<RecoveryRepository>(
    create: (context) => RecoveryRepository(
      service: context.read(),
    ),
  ),
];
