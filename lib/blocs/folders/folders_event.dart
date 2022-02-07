part of 'folders_bloc.dart';

abstract class FoldersEvent extends Equatable {
  const FoldersEvent();

  @override
  List<Object?> get props => [];
}

class FetchFoldersEvent extends FoldersEvent {
  final Directory directory;

  const FetchFoldersEvent(this.directory);

  @override
  List<Object?> get props => [directory];
}
