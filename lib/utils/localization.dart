import 'package:flutter/cupertino.dart';

class BlocLocalizations {

  static BlocLocalizations of(BuildContext context) {
    return Localizations.of<BlocLocalizations>(context, BlocLocalizations);
  }

  String get appTitle => "Bijuteri";

}

class InheritedWidgetLocalizationsDelegate extends LocalizationsDelegate<BlocLocalizations> {
  @override
  Future<BlocLocalizations> load(Locale locale) =>
      Future(() => BlocLocalizations());

  @override
  bool shouldReload(InheritedWidgetLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      ['tr','en'].contains(locale.languageCode);

}
