part of 'folders_cubit.dart';

@freezed
class FoldersState with _$FoldersState {
  const FoldersState._();

  const factory FoldersState.fetching() = _FetchingFoldersState;

  const factory FoldersState.fetched(
    Directory directory, {
    @Default([]) List<Directory> folders,
  }) = _FetchedFoldersState;
}
