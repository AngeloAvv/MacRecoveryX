import 'dart:async';
import 'dart:io';

import 'package:macrecovery_x/extensions/uri_extensions.dart';
import 'package:macrecovery_x/models/download_status.dart';
import 'package:macrecovery_x/models/os.dart';
import 'package:macrecovery_x/services/recovery_service.dart';
import 'package:path/path.dart';

class RecoveryRepository {
  final RecoveryService service;

  RecoveryRepository({required this.service});

  Future<String?> get session => service.requestSession();

  Future<Map<String, String>> getDetails({
    required String session,
    required OS os,
    required Directory destination,
  }) =>
      service.requestDetails(
        mlb: os.mlb,
        boardId: os.boardId,
        session: session,
      );

  Stream<DownloadStatus> saveFile(
    String url, {
    required String session,
    required OS os,
    required Directory destination,
  }) async* {
    final uri = Uri.parse(url);
    final filePath = join(destination.path, uri.name);
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }

    await file.create();

    final response = await service.requestFile(url: url, session: session);

    final contentLength = response.contentLength ?? 0;
    var downloadedLength = 0;

    yield* response.stream.transform(
      StreamTransformer<List<int>, DownloadStatus>.fromHandlers(
          handleData: (bytes, sink) {
        downloadedLength += bytes.length;

        file.writeAsBytes(bytes, mode: FileMode.append);

        sink.add(
          DownloadStatus(
            progress: downloadedLength / contentLength,
            completed: downloadedLength == contentLength,
            file: file,
          ),
        );
      }, handleDone: (sink) {
        sink.add(
          DownloadStatus(
            progress: 1,
            completed: true,
            file: file,
          ),
        );
      }),
    );
  }
}
