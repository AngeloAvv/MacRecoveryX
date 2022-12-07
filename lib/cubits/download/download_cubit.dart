import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/repositories/recovery_repository.dart';
import 'package:macrecovery_x/services/recovery_service.dart';
import 'package:rxdart/rxdart.dart';

part 'download_cubit.freezed.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final RecoveryRepository recoveryRepository;

  DownloadCubit({required this.recoveryRepository})
      : super(const DownloadState.downloading(0));

  Future<void> startDownload({
    required OS os,
    required Directory destination,
  }) async {
    final session = await recoveryRepository.session;
    if (session == null) {
      emit(const DownloadState.error());
    }

    if (session != null) {
      final info = await recoveryRepository.getDetails(
        session: session,
        os: os,
        destination: destination,
      );

      final imageUrl = info[RecoveryService.infoImageLink];
      final imageSession = info[RecoveryService.infoImageSess];
      final checksumUrl = info[RecoveryService.infoSignLink];
      final checksumSession = info[RecoveryService.infoSignSess];

      if (imageUrl != null &&
          imageSession != null &&
          checksumUrl != null &&
          checksumSession != null) {
        Rx.combineLatest2(
            recoveryRepository.saveFile(
              imageUrl,
              session: imageSession,
              os: os,
              destination: destination,
            ),
            recoveryRepository.saveFile(
              checksumUrl,
              session: checksumSession,
              os: os,
              destination: destination,
            ), (imageStream, checksumStream) {
          if (imageStream.completed && checksumStream.completed) {
            return DownloadState.downloaded(destination);
          }

          return DownloadState.downloading(
            min(imageStream.progress, checksumStream.progress),
          );
        }).listen((state) => emit(state));
      } else {
        emit(const DownloadState.error());
      }
    }
  }
}
