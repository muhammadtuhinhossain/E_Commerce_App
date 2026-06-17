import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

extension LocalizationExtension on BuildContext{
  AppLocalizations get localization => AppLocalizations.of(this)!;
}