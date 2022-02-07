import 'dart:io';

class FileExplorerRepository {
  Future<List<Directory>> getFolders(Directory directory) async {
    final items = await directory.list().toList();

    return items.whereType<Directory>().toList(growable: false);
  }
}
