import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macrecovery_x/cubits/folder_cubit.dart';
import 'package:macrecovery_x/cubits/folders/folders_cubit.dart';
import 'package:macrecovery_x/cubits/step_cubit.dart';
import 'package:macrecovery_x/cubits/wizard/wizard_cubit.dart';
import 'package:macrecovery_x/extensions/directory_extensions.dart';
import 'package:macrecovery_x/features/localization/extensions/build_context.dart';
import 'package:macrecovery_x/router/app_router.dart';
import 'package:macrecovery_x/widgets/folder_item.dart';
import 'package:macrecovery_x/widgets/loading_widget.dart';

@RoutePage()
class FolderPage extends StatelessWidget implements AutoRouteWrapper {
  const FolderPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FolderCubit(
              wizardCubit: context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => FoldersCubit(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: BlocBuilder<FoldersCubit, FoldersState>(
                builder: (context, state) => state.when(
                  fetching: () => const LoadingWidget(),
                  fetched: (directory, folders) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CurrentDirectory(
                          directory.parents.reversed.toList(growable: false)),
                      Expanded(
                        child: FoldersTree(folders),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<FolderCubit, Directory?>(
            builder: (context, selectedDirectory) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.router.navigate(OSRoute());
                    context.read<StepCubit>().prev();
                  },
                  child: Text(context.l10n?.action_prev ?? 'action_prev'),
                ),
                ElevatedButton(
                  onPressed: selectedDirectory != null
                      ? () {
                          context.router.navigate(
                            DownloadRoute(
                              os: context.read<WizardCubit>().state.os!,
                              destination: context
                                  .read<WizardCubit>()
                                  .state
                                  .destination!,
                            ),
                          );
                          context.read<StepCubit>().next();
                        }
                      : null,
                  child: Text(context.l10n?.action_use_this_folder ??
                      'action_use_this_folder'),
                ),
              ],
            ),
          ),
        ],
      );
}

class CurrentDirectory extends StatelessWidget {
  final List<Directory> directories;

  const CurrentDirectory(this.directories, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: directories
              .mapIndexed(
                (index, folder) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(index == 0 ? 25 : 0),
                        bottomLeft: Radius.circular(index == 0 ? 25 : 0),
                        topRight: Radius.circular(
                            index == directories.length - 1 ? 25 : 0),
                        bottomRight: Radius.circular(
                            index == directories.length - 1 ? 25 : 0),
                      ),
                    ),
                  ),
                  child: Center(
                    child:
                        index == 0 ? const Icon(Icons.home) : Text(folder.name),
                  ),
                  onPressed: () =>
                      context.read<FoldersCubit>().fetchFolders(folder),
                ),
              )
              .toList(growable: false),
        ),
      );
}

class FoldersTree extends StatelessWidget {
  final List<Directory> folders;
  final _scrollController = ScrollController();

  FoldersTree(this.folders, {super.key});

  @override
  Widget build(BuildContext context) => Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: folders
                .map(
                  (folder) => FolderItem(
                    folder,
                    onTap: () =>
                        context.read<FoldersCubit>().fetchFolders(folder),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      );
}
