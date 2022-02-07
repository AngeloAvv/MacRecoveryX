import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/blocs/download/download_bloc.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/router/app_router.gr.dart';

class DownloadPage extends StatelessWidget with AutoRouteWrapper {
  final OS os;
  final Directory destination;

  const DownloadPage({
    required this.os,
    required this.destination,
    Key? key,
  }) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => DownloadBloc(
          recoveryRepository: context.read(),
        )..startDownload(os: os, destination: destination),
        child: this,
      );

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DownloadBloc, DownloadState>(
        listener: (context, state) {
          if (state is DownloadedState) {
            context.read<StepCubit>().next();
            context.router.navigate(FinishRoute(directory: state.directory));
          }
        },
        builder: (context, state) {
          if (state is DownloadingState) {
            return _body(context, state: state);
          }

          return Container();
        },
      );

  Widget _body(
    BuildContext context, {
    required DownloadingState state,
  }) =>
      Column(
        children: [
          _progressIndicator(context, progress: state.progress),
          _stepIndicator(context, step: state.step),
        ],
      );

  Widget _progressIndicator(BuildContext context, {double progress = 0}) =>
      Expanded(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '${min(progress * 100, 100).toInt()} %',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                width: 256,
                height: 256,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 30,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _stepIndicator(BuildContext context, {int step = 1}) => Column(
        children: [
          Text(AppLocalizations.of(context)?.label_step(step) ?? ''),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinearProgressIndicator(
              value: step / 2,
              minHeight: 30,
            ),
          ),
        ],
      );
}
