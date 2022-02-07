import 'dart:io';

import 'package:equatable/equatable.dart';

class DownloadStatus extends Equatable {
  final double progress;
  final bool completed;
  final File file;

  const DownloadStatus({
    required this.progress,
    required this.file,
    this.completed = false,
  });

  @override
  List<Object?> get props => [
        progress,
        completed,
        file,
      ];
}
