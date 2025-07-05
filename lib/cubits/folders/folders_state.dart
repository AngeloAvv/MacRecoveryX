part of 'folders_cubit.dart';

@freezed
sealed class FoldersState with _$FoldersState {
  const FoldersState._();

  const factory FoldersState.fetching() = FetchingFoldersState;

  const factory FoldersState.fetched(
    Directory directory, {
    @Default([]) List<Directory> folders,
  }) = FetchedFoldersState;
}
