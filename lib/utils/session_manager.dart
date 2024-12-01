import 'package:cn_delivery/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late final SharedPreferences sharedPrefs;
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

static bool get firstTimeLanguageScreen =>
      sharedPrefs.getBool(Constants.FIRST_TIME_LANGUAGE_SCREEN) ??false;
  static set setFirstTimeLanguageScreen(bool value) {
    sharedPrefs.setBool(Constants.FIRST_TIME_LANGUAGE_SCREEN, value);
  }
  static bool get introScreen =>
      sharedPrefs.getBool(Constants.INTRO_SCREEN) ??false;
  static set setIntroScreen(bool value) {
    sharedPrefs.setBool(Constants.INTRO_SCREEN, value);
  }
  static String get token => sharedPrefs.getString(Constants.TOKEN) ?? "";
  static set setToken(String value) {
    sharedPrefs.setString(Constants.TOKEN, value);
  }
  static String get lat => sharedPrefs.getString(Constants.LAT) ?? "";
  static set setLat(String value) {
    sharedPrefs.setString(Constants.LAT, value);
  }
  static String get lng => sharedPrefs.getString(Constants.LNG) ?? "";
  static set setLng(String value) {
    sharedPrefs.setString(Constants.LNG, value);
  }static String get address => sharedPrefs.getString(Constants.ADDRESS) ?? "";
  static set setAddress(String value) {
    sharedPrefs.setString(Constants.ADDRESS, value);
  }

  static String get fcmToken =>
      sharedPrefs.getString(Constants.FCM_TOKEN) ?? "";
  static set setFcmToken(String value) {
    sharedPrefs.setString(Constants.FCM_TOKEN, value);
  }

  static String get languageCode =>
      sharedPrefs.getString(Constants.languageCode) ?? "";
  static set setLanguageCode(String value) {
    sharedPrefs.setString(Constants.languageCode, value);
  }

  static String get countryCode =>
      sharedPrefs.getString(Constants.countryCode) ?? "";
  static set setCountryCode(String value) {
    sharedPrefs.setString(Constants.countryCode, value);
  }
}
