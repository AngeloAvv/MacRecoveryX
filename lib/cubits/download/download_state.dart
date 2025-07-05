part of 'download_cubit.dart';

@freezed
sealed class DownloadState with _$DownloadState {
  const DownloadState._();

  const factory DownloadState.downloading(double progress) = DownloadingState;

  const factory DownloadState.downloaded(Directory directory) = DownloadedState;

  const factory DownloadState.error() = DownloadErrorState;
}
