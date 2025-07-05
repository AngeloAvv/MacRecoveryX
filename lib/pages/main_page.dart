import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/features/localization/extensions/build_context.dart';
import 'package:macrecovery_x/models/step.dart' as models;
import 'package:macrecovery_x/widgets/step_item.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              Card(
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
                            step,
                            current: step == currentStep,
                            done: currentStep < step,
                          ),
                        )
                        .toList(growable: false),
                  ),
                ),
              ),
              const Expanded(child: AutoRouter()),
            ],
          ),
        ),
      );

  Widget _connectivityChecker(BuildContext context) =>
      StreamBuilder<List<ConnectivityResult>>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!.contains(ConnectivityResult.none)) {
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
              context.l10n?.label_no_internet_title ??
                  'label_no_internet_title',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              context.l10n?.label_no_internet_message ??
                  'label_no_internet_message',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
}
