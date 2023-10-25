import 'dart:io';

import 'package:flutter/material.dart';
import 'package:macrecovery_x/extensions/directory_extensions.dart';

class FolderItem extends StatelessWidget {
  final Directory directory;
  final VoidCallback? onTap;

  const FolderItem(
    this.directory, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Column(
          children: [
            _icon(),
            _name(),
          ],
        ),
      );

  Widget _icon() => Icon(
        Icons.folder,
        size: 64,
        color: Colors.blue[100],
      );

  Widget _name() => SizedBox(
        width: 100,
        child: Column(
          children: [
            Text(
              directory.name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
