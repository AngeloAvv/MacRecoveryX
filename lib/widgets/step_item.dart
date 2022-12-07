import 'package:flutter/material.dart';
import 'package:macrecovery_x/models/step.dart' as models;

class StepItem extends StatelessWidget {
  final models.Step step;
  final bool current;

  final bool done;

  const StepItem(
    this.step, {
    Key? key,
    this.current = false,
    this.done = false,
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
                    color: current || done
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  color: current
                      ? Theme.of(context).primaryColor
                      : done
                          ? Colors.white
                          : Theme.of(context).colorScheme.secondary,
                ),
                child: Center(
                  child: Text(
                    (step.index + 1).toString(),
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight:
                              current ? FontWeight.bold : FontWeight.normal,
                          color: done
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
                      fontWeight: current ? FontWeight.bold : FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      );
}
