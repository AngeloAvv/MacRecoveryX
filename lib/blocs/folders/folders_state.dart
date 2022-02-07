part of 'folders_bloc.dart';

abstract class FoldersState extends Equatable {
  const FoldersState();

  @override
  List<Object> get props => [];
}

class FetchingFoldersState extends FoldersState {}

class FetchedFoldersState extends FoldersState {
  final Directory directory;
  final List<Directory> folders;

  const FetchedFoldersState(
    this.directory, {
    this.folders = const [],
  });

  @override
  List<Object> get props => [directory, folders];
}
