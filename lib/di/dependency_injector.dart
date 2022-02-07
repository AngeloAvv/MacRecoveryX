import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';
import 'package:macrecovery_x/repositories/file_explorer_repository.dart';
import 'package:macrecovery_x/repositories/recovery_repository.dart';
import 'package:macrecovery_x/services/recovery_service.dart';
import 'package:provider/provider.dart';

part 'blocs.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _Providers(
        child: _Repositories(
          child: _Blocs(child: child),
        ),
      );
}
