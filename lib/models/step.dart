import 'package:flutter/cupertino.dart';
import 'package:macrecovery_x/features/localization/extensions/build_context.dart';

enum Step {
  welcome,
  os,
  destination,
  download,
  finish;

  bool operator <(Object other) =>
      runtimeType == other.runtimeType && index < (other as Step).index;
}

extension LocalizedStep on Step {
  String? label(BuildContext context) {
    switch (index) {
      case 0:
        return context.l10n?.step_one;
      case 1:
        return context.l10n?.step_two;
      case 2:
        return context.l10n?.step_three;
      case 3:
        return context.l10n?.step_four;
      case 4:
        return context.l10n?.step_five;
    }
    return null;
  }
}
