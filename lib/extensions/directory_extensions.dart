import 'dart:io';

extension DirectoryExtensions on Directory {
  String get name => path.split(Platform.isWindows ? '\\' : '/').last;

  List<Directory> get parents {
    final parents = <Directory>[];

    var currentDirectory = this;
    while (parents.isEmpty || parents.last.name != currentDirectory.name) {
      parents.add(currentDirectory);
      currentDirectory = currentDirectory.parent;
    }

    return parents;
  }
}
