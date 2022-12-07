import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/router/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)?.label_welcome_title ?? '',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      AppLocalizations.of(context)?.label_welcome_subtitle ??
                          ''),
                ),
                InkWell(
                  onTap: () async =>
                      await launchUrlString('https://github.com/AngeloAvv'),
                  child: Text(
                    AppLocalizations.of(context)
                            ?.label_welcome_call_to_action ??
                        '',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.router.navigate(const OSRoute());
                  context.read<StepCubit>().next();
                },
                child: Text(AppLocalizations.of(context)?.action_next ?? ''),
              ),
            ],
          ),
        ],
      );
}
