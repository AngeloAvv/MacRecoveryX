part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadingState extends DownloadState {
  final double progress;
  final int step;

  const DownloadingState({
    this.progress = 0,
    this.step = 1,
  });

  @override
  List<Object> get props => [
        progress,
        step,
      ];
}

class DownloadedState extends DownloadState {
  final Directory directory;

  const DownloadedState(this.directory);

  @override
  List<Object> get props => [directory];
}

class DownloadErrorState extends DownloadState {}
