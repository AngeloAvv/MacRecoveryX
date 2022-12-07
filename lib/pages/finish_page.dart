import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/router/app_router.gr.dart';
import 'package:provider/provider.dart';

class FinishPage extends StatelessWidget {
  final Directory directory;

  const FinishPage(this.directory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)?.label_finish_title ?? '',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.black,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline6,
                text: AppLocalizations.of(context)?.label_finish_subtitle ?? '',
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
                  Text(AppLocalizations.of(context)?.action_start_over ?? ''),
            ),
          ),
        ],
      );
}
