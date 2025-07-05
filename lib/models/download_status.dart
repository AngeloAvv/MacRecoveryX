import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_status.freezed.dart';

@freezed
abstract class DownloadStatus with _$DownloadStatus {
  const factory DownloadStatus({
    required double progress,
    required File file,
    @Default(false) bool completed,
  }) = _DownloadStatus;
}
