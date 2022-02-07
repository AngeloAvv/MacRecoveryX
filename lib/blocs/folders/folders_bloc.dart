import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:macrecovery_x/cubits/folder_cubit.dart';
import 'package:macrecovery_x/extensions/directory_extensions.dart';
import 'package:macrecovery_x/repositories/file_explorer_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  final FolderCubit folderCubit;
  final FileExplorerRepository fileExplorerRepository;

  FoldersBloc({
    required this.folderCubit,
    required this.fileExplorerRepository,
  }) : super(FetchingFoldersState()) {
    on<FetchFoldersEvent>(_mapFetchFoldersEventToState);
  }

  void _mapFetchFoldersEventToState(
      FetchFoldersEvent event, Emitter<FoldersState> emit) async {
    emit(FetchingFoldersState());
    final folders = await fileExplorerRepository.getFolders(event.directory);
    folders.sort((a, b) => a.name.compareTo(b.name));

    folderCubit.select(event.directory);

    emit(FetchedFoldersState(event.directory, folders: folders));
  }

  void fetchFolders([Directory? directory]) async {
    final requestedFolder = directory ?? await getDownloadsDirectory();
    if (requestedFolder != null) {
      add(FetchFoldersEvent(requestedFolder));
    }
  }
}
