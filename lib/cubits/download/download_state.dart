part of 'download_cubit.dart';

@freezed
class DownloadState with _$DownloadState {
  const DownloadState._();

  const factory DownloadState.downloading(double progress) = _DownloadingState;

  const factory DownloadState.downloaded(Directory directory) =
      _DownloadedState;

  const factory DownloadState.error() = _DownloadErrorState;
}
