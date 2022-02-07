import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Step extends Equatable {
  static const values = [
    Step.welcome,
    Step.os,
    Step.destination,
    Step.download,
    Step.finish,
  ];

  final String path;
  final int number;

  const Step(
    this.path, {
    required this.number,
  });

  factory Step.welcome() => const Step('welcome', number: 1);

  factory Step.os() => const Step('os', number: 2);

  factory Step.destination() => const Step('destination', number: 3);

  factory Step.download() => const Step('download', number: 4);

  factory Step.finish() => const Step('finish', number: 5);

  @override
  List<Object?> get props => [path, number];

  bool operator <(Object other) =>
      runtimeType == other.runtimeType && number < (other as Step).number;
}

extension LocalizedStep on Step {
  String? label(BuildContext context) {
    switch (number) {
      case 1:
        return AppLocalizations.of(context)?.step_one;
      case 2:
        return AppLocalizations.of(context)?.step_two;
      case 3:
        return AppLocalizations.of(context)?.step_three;
      case 4:
        return AppLocalizations.of(context)?.step_four;
      case 5:
        return AppLocalizations.of(context)?.step_five;
    }
    return null;
  }
}
