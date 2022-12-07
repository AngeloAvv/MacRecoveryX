import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return AppLocalizations.of(context)?.step_one;
      case 1:
        return AppLocalizations.of(context)?.step_two;
      case 2:
        return AppLocalizations.of(context)?.step_three;
      case 3:
        return AppLocalizations.of(context)?.step_four;
      case 4:
        return AppLocalizations.of(context)?.step_five;
    }
    return null;
  }
}
