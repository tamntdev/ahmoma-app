import 'package:ahmoma_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

extension LocaleSupport on BuildContext {
  AppLocalizations get locale {
    AppLocalizations? locale =  AppLocalizations.of(this);

    if(locale == null) {
      throw Exception('Locale is requested before Localisation intitialised!');
    }

    return locale;
  }
}