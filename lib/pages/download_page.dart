import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/download/download_cubit.dart';
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
        create: (context) => DownloadCubit(
          recoveryRepository: context.read(),
        )..startDownload(os: os, destination: destination),
        child: this,
      );

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<DownloadCubit, DownloadState>(
        listener: (context, state) => state.whenOrNull(downloaded: (directory) {
          context.read<StepCubit>().next();
          context.router.navigate(FinishRoute(directory: directory));

          return null;
        }),
        builder: (context, state) => state.maybeWhen(
          downloading: (progress) => Center(
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
          orElse: () => const SizedBox(),
        ),
      );
}
