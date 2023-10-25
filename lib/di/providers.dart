part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<RecoveryService>(create: (_) => RecoveryService()),
];
