part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  final OS os;
  final Directory destination;

  const DownloadEvent({
    required this.os,
    required this.destination,
  });

  @override
  List<Object?> get props => [
        os,
        destination,
      ];
}

class StartDownloadEvent extends DownloadEvent {
  const StartDownloadEvent({
    required OS os,
    required Directory destination,
  }) : super(
          os: os,
          destination: destination,
        );
}

class UpdateDownloadStatusEvent extends DownloadEvent {
  final Map<String, String> info;
  final DownloadStatus status;
  final int step;

  const UpdateDownloadStatusEvent(
    this.status, {
    required this.info,
    required OS os,
    required Directory destination,
    this.step = 1,
  }) : super(os: os, destination: destination);

  @override
  List<Object?> get props => [...super.props, status, info, step];
}

class DownloadChecksumEvent extends DownloadEvent {
  final Map<String, String> info;

  const DownloadChecksumEvent({
    required this.info,
    required OS os,
    required Directory destination,
  }) : super(os: os, destination: destination);

  @override
  List<Object?> get props => [...super.props, info];
}
