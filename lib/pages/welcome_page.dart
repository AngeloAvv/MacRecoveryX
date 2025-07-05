import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/features/localization/extensions/build_context.dart';
import 'package:macrecovery_x/router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.l10n?.label_welcome_title ?? 'label_welcome_title',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      context.l10n?.label_welcome_subtitle ??
                          'label_welcome_subtitle'),
                ),
                InkWell(
                  onTap: () async =>
                      await launchUrlString('https://github.com/AngeloAvv'),
                  child: Text(
                    context.l10n
                            ?.label_welcome_call_to_action ??
                        'label_welcome_call_to_action',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  context.router.navigate(OSRoute());
                  context.read<StepCubit>().next();
                },
                child: Text(context.l10n?.action_next ?? 'action_next'),
              ),
            ],
          ),
        ],
      );
}
