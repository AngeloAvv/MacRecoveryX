import 'package:flutter/material.dart';
import 'package:macrecovery_x/models/step.dart' as models;

class StepItem extends StatelessWidget {
  final models.Step step;
  final models.Step current;

  const StepItem({
    Key? key,
    required this.step,
    required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Material(
              elevation: 2,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _this || _passed
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  color: _this
                      ? Theme.of(context).primaryColor
                      : _passed
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary,
                ),
                child: Center(
                  child: Text(
                    step.number.toString(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight:
                              _this ? FontWeight.bold : FontWeight.normal,
                          color: _passed
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                step.label(context) ?? '',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: _this ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      );

  bool get _this => step == current;

  bool get _passed => current < step;
}
