import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:macrecovery_x/blocs/folders/folders_bloc.dart';
import 'package:macrecovery_x/cubits/folder_cubit.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';
import 'package:macrecovery_x/extensions/directory_extensions.dart';
import 'package:macrecovery_x/router/app_router.gr.dart';
import 'package:macrecovery_x/widgets/folder_item.dart';

class FolderPage extends StatelessWidget with AutoRouteWrapper {
  const FolderPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FolderCubit(
              wizardCubit: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => FoldersBloc(
              fileExplorerRepository: context.read(),
              folderCubit: context.read(),
            )..fetchFolders(),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _body(context),
          _navigationButtons(context),
        ],
      );

  Widget _body(BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: BlocBuilder<FoldersBloc, FoldersState>(
            builder: (context, state) {
              if (state is FetchingFoldersState) {
                return _circularProgressIndicator();
              } else if (state is FetchedFoldersState) {
                return _foldersBody(
                  context,
                  state: state,
                );
              }

              return Container();
            },
          ),
        ),
      );

  Widget _foldersBody(
    BuildContext context, {
    required FetchedFoldersState state,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _currentDirectory(
            context,
            state: state,
          ),
          _foldersTree(
            context,
            state: state,
          ),
        ],
      );

  Widget _currentDirectory(
    BuildContext context, {
    required FetchedFoldersState state,
  }) {
    final items = state.directory.parents.reversed.toList(growable: false);

    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items
            .mapIndexed(
              (index, folder) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(index == 0 ? 25 : 0),
                      bottomLeft: Radius.circular(index == 0 ? 25 : 0),
                      topRight:
                          Radius.circular(index == items.length - 1 ? 25 : 0),
                      bottomRight:
                          Radius.circular(index == items.length - 1 ? 25 : 0),
                    ),
                  ),
                ),
                child: Center(
                  child:
                      index == 0 ? const Icon(Icons.home) : Text(folder.name),
                ),
                onPressed: () =>
                    context.read<FoldersBloc>().fetchFolders(folder),
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  Widget _foldersTree(
    BuildContext context, {
    required FetchedFoldersState state,
  }) =>
      Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: state.folders
                  .map(
                    (folder) => FolderItem(
                      folder,
                      onTap: () =>
                          context.read<FoldersBloc>().fetchFolders(folder),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      );

  Widget _circularProgressIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget _navigationButtons(BuildContext context) =>
      BlocBuilder<FolderCubit, Directory?>(
        builder: (context, selectedDirectory) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                context.router.navigate(const OSRoute());
                context.read<StepCubit>().prev();
              },
              child: Text(AppLocalizations.of(context)?.action_prev ?? ''),
            ),
            ElevatedButton(
              onPressed: selectedDirectory != null
                  ? () {
                      context.router.navigate(
                        DownloadRoute(
                          os: context.read<WizardCubit>().state.os!,
                          destination:
                              context.read<WizardCubit>().state.destination!,
                        ),
                      );
                      context.read<StepCubit>().next();
                    }
                  : null,
              child: Text(
                  AppLocalizations.of(context)?.action_use_this_folder ?? ''),
            ),
          ],
        ),
      );
}
