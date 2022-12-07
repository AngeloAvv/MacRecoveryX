import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macrecovery_x/cubits/folder_cubit.dart';
import 'package:macrecovery_x/extensions/directory_extensions.dart';
import 'package:macrecovery_x/repositories/file_explorer_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'folders_cubit.freezed.dart';
part 'folders_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  final FolderCubit folderCubit;
  final FileExplorerRepository fileExplorerRepository;

  FoldersCubit({
    required this.folderCubit,
    required this.fileExplorerRepository,
  }) : super(const FoldersState.fetching());

  void fetchFolders([Directory? directory]) async {
    final requestedFolder = directory ?? await getDownloadsDirectory();

    if (requestedFolder != null) {
      emit(const FoldersState.fetching());
      final folders = await fileExplorerRepository.getFolders(requestedFolder);
      folders.sort((a, b) => a.name.compareTo(b.name));

      folderCubit.select(requestedFolder);

      emit(FoldersState.fetched(requestedFolder, folders: folders));
    }
  }
}
