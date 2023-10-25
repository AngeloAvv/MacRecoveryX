import 'package:flutter/material.dart';
import 'package:macrecovery_x/models/os.dart';

class OSItem extends StatelessWidget {
  final OS os;
  final bool selected;
  final VoidCallback? onTap;

  const OSItem(
    this.os, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: selected
            ? Theme.of(context).colorScheme.secondary
            : Colors.blue[100],
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Column(
                children: [
                  _image(context),
                  _body(context),
                ],
              ),
              if (selected) _check(context),
            ],
          ),
        ),
      );

  Widget _image(BuildContext context) => Expanded(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Image.asset(os.avatar, width: 300, fit: BoxFit.cover),
        ),
      );

  Widget _check(BuildContext context) => Positioned(
        right: 16,
        top: 16,
        child: Icon(
          Icons.check_circle,
          size: 56,
          color: Theme.of(context).colorScheme.secondary,
        ),
      );

  Widget _body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _title(context),
            _subtitle(context),
          ],
        ),
      );

  Widget _title(BuildContext context) => Text(
        os.name,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.black),
      );

  Widget _subtitle(BuildContext context) => Text(
        os.version,
        style: Theme.of(context).textTheme.titleLarge,
      );
}
