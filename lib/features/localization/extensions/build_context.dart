import 'package:flutter/material.dart' hide Route;
import 'package:macrecovery_x/features/localization/app_localizations.dart';

extension BuildContextLocalizations on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
