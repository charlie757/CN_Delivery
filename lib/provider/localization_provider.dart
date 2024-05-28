import 'package:cn_delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = Locale(
      Constants.languages[0].languageCode!, Constants.languages[0].countryCode);
  bool _isLtr = true;
  int? _languageIndex;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int? get languageIndex => _languageIndex;

  void setLanguage(Locale locale) {
    _locale = locale;
    _isLtr = _locale.languageCode != 'ar';
    // dioClient!.updateHeader(null, locale.countryCode);
    for (int index = 0; index < Constants.languages.length; index++) {
      if (Constants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  loadCurrentLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _locale = Locale(
        sharedPreferences.getString(Constants.languageCode) ??
            Constants.languages[0].languageCode!,
        sharedPreferences.getString(Constants.countryCode) ??
            Constants.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < Constants.languages.length; index++) {
      if (Constants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Constants.languageCode, locale.languageCode);
    sharedPreferences.setString(Constants.countryCode, locale.countryCode!);
  }
}
