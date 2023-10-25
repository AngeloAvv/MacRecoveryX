import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/cubits/os_cubit.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/router/app_router.dart';
import 'package:macrecovery_x/widgets/os_item.dart';

@RoutePage()
class OSPage extends StatelessWidget implements AutoRouteWrapper {
  final _scrollController = ScrollController();

  OSPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => OSCubit(
          wizardCubit: context.read(),
        ),
        child: this,
      );

  @override
  Widget build(BuildContext context) => BlocBuilder<OSCubit, OS?>(
        builder: (context, selectedOS) => Column(
          children: [
            _body(context, selectedOS: selectedOS),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.router.navigate(const WelcomeRoute());
                    context.read<StepCubit>().prev();
                  },
                  child: Text(AppLocalizations.of(context)?.action_prev ?? 'action_prev'),
                ),
                ElevatedButton(
                  onPressed: selectedOS != null
                      ? () {
                          context.router.navigate(const FolderRoute());
                          context.read<StepCubit>().next();
                        }
                      : null,
                  child: Text(AppLocalizations.of(context)?.action_next ?? 'action_next'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _body(
    BuildContext context, {
    required OS? selectedOS,
  }) {
    final widgets = OS.values.reversed.map(
      (osReference) {
        final os = osReference.call();

        return OSItem(
          os,
          selected: os == selectedOS,
          onTap: () => context.read<OSCubit>().toggle(os),
        );
      },
    ).toList(growable: false);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => widgets[index],
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemCount: widgets.length,
          ),
        ),
      ),
    );
  }
}
