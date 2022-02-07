import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:macrecovery_x/models/download_status.dart';
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/repositories/recovery_repository.dart';
import 'package:macrecovery_x/services/recovery_service.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final RecoveryRepository recoveryRepository;

  DownloadBloc({required this.recoveryRepository})
      : super(const DownloadingState()) {
    on<StartDownloadEvent>(_mapStartDownloadEventToState);
    on<UpdateDownloadStatusEvent>(_mapUpdateDownloadStatusEventToState);
    on<DownloadChecksumEvent>(_mapDownloadChecksumEventToState);
  }

  void _mapStartDownloadEventToState(
    StartDownloadEvent event,
    Emitter<DownloadState> emit,
  ) async {
    final session = await recoveryRepository.session;
    if (session == null) {
      emit(DownloadErrorState());
    }

    if (session != null) {
      final info = await recoveryRepository.getDetails(
        session: session,
        os: event.os,
        destination: event.destination,
      );

      final url = info[RecoveryService.infoImageLink];
      final nestedSession = info[RecoveryService.infoImageSess];

      if (url != null && nestedSession != null) {
        recoveryRepository
            .saveFile(
              url,
              session: nestedSession,
              os: event.os,
              destination: event.destination,
            )
            .listen(
              (status) => add(
                UpdateDownloadStatusEvent(
                  status,
                  os: event.os,
                  destination: event.destination,
                  info: info,
                ),
              ),
            );
      } else {
        emit(DownloadErrorState());
      }
    }
  }

  void _mapUpdateDownloadStatusEventToState(
    UpdateDownloadStatusEvent event,
    Emitter<DownloadState> emit,
  ) {
    emit(
      DownloadingState(
        progress: event.status.progress,
        step: event.step,
      ),
    );

    if (event.status.completed) {
      if (event.step == 1) {
        add(
          DownloadChecksumEvent(
            os: event.os,
            destination: event.destination,
            info: event.info,
          ),
        );
      } else if (event.step == 2) {
        emit(DownloadedState(event.destination));
      }
    }
  }

  void _mapDownloadChecksumEventToState(
    DownloadChecksumEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadingState(step: 2));

    final info = event.info;
    final url = info[RecoveryService.infoSignLink];
    final nestedSession = info[RecoveryService.infoSignSess];

    if (url != null && nestedSession != null) {
      recoveryRepository
          .saveFile(
            url,
            session: nestedSession,
            os: event.os,
            destination: event.destination,
          )
          .listen(
            (status) => add(
              UpdateDownloadStatusEvent(
                status,
                os: event.os,
                destination: event.destination,
                info: info,
                step: 2,
              ),
            ),
          );
    } else {
      emit(DownloadErrorState());
    }
  }

  void startDownload({
    required OS os,
    required Directory destination,
  }) =>
      add(
        StartDownloadEvent(
          os: os,
          destination: destination,
        ),
      );
}
