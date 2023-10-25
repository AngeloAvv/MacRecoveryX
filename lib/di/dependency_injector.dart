import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';
import 'package:macrecovery_x/repositories/file_explorer_repository.dart';
import 'package:macrecovery_x/repositories/recovery_repository.dart';
import 'package:macrecovery_x/services/recovery_service.dart';
import 'package:pine/di/dependency_injector_helper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

part 'blocs.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        blocs: _blocs,
        providers: _providers,
        repositories: _repositories,
        child: child,
      );
}
