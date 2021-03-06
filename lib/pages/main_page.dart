import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/models/step.dart' as models;
import 'package:macrecovery_x/widgets/step_item.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _connectivityChecker(context),
      );

  Widget _body(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(32),
        child: BlocBuilder<StepCubit, models.Step>(
          builder: (context, currentStep) => Column(
            children: [
              _progress(currentStep),
              _currentStep(),
            ],
          ),
        ),
      );

  Widget _progress(models.Step currentStep) => Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: models.Step.values
                .map(
                  (step) => StepItem(
                    step: step.call(),
                    current: currentStep,
                  ),
                )
                .toList(growable: false),
          ),
        ),
      );

  Widget _connectivityChecker(BuildContext context) =>
      StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != ConnectivityResult.none) {
              return _body(context);
            } else {
              return _noConnection(context);
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      );

  Widget _noConnection(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 256, color: Colors.grey),
            Text(
              AppLocalizations.of(context)?.label_no_internet_title ?? '',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              AppLocalizations.of(context)?.label_no_internet_message ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );

  Widget _currentStep() => const Expanded(
        child: AutoRouter(),
      );
}
