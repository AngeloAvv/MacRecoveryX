import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/features/localization/extensions/build_context.dart';
import 'package:macrecovery_x/router/app_router.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FinishPage extends StatelessWidget {
  final Directory directory;

  const FinishPage(this.directory, {super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.l10n?.label_finish_title ?? 'label_finish_title',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleLarge,
                text: context.l10n?.label_finish_subtitle ??
                    'label_finish_subtitle',
                children: [
                  TextSpan(
                    text: directory.path,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: ElevatedButton(
              onPressed: () {
                context.router.navigate(const WelcomeRoute());
                context.read<StepCubit>().init();
              },
              child:
                  Text(context.l10n?.action_start_over ?? 'action_start_over'),
            ),
          ),
        ],
      );
}
