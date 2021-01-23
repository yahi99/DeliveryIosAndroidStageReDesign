import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations{
  Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationDelegate();

  static AppLocalizations of (BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  AppLocalizations(this.locale);

  Map<String, dynamic> languageMap = Map();
  Future load() async {
    final fileString =
        await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
     languageMap = json.decode(fileString);
  }

  getTranslation(String key){
    if(!key.contains('.'))
      return languageMap[key];

    List<String> keys = key.split('.');
    var tempEntry;
    keys.forEach((key) {
      tempEntry = (tempEntry == null) ? languageMap[key] : tempEntry[key];
    });

    String result = tempEntry.toString();

    return result;
  }
}


class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{

  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale){
    return ['ru', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async{
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}