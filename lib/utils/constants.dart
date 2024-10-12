// ignore_for_file: non_constant_identifier_names

import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/language_model.dart';
import 'package:cn_delivery/utils/utils.dart';

class Constants {
  static String FIRST_TIME_OPEN_APP = 'FIRST_TIME_OPEN_APP';
  static String TOKEN = 'token';
  static String KEEP_ME_SIGNED_IN = 'KEEP_ME_SIGNED_IN';
  static String EMAIL_ID = 'EMAIL_ID';
  static String PASSWORD = 'PASSWORD';
  static String FCM_TOKEN = 'FCM_TOKEN';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static String FIRST_TIME_LANGUAGE_SCREEN = 'FIRST_TIME_LANGUAGE_SCREEN';
  static String LAT = 'LAT';
  static String LNG = 'LNG';
  static String ADDRESS = 'ADDRESS';

static String androidGoogleMapKey = 'AIzaSyAFg444yhMDNO_8DG9qMFFlPJOr3LlQ5dE';
static String iosGoogleMapKey = 'AIzaSyDuKSn9jBZ-2Qs6XD0VQNlxsIsAKjha0Yk';

  ///
  static bool is401Error = false; /// true if logout it and false if relogin

 static List vehicleTypeList = [
    getTranslated('biCycle', navigatorKey.currentContext!)!,
    getTranslated('bike', navigatorKey.currentContext!)!,
    getTranslated('car', navigatorKey.currentContext!)!,
    // getTranslated('suv', navigatorKey.currentContext!)!,
    // getTranslated('muv', navigatorKey.currentContext!)!,
  ];
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Spanish',
        countryCode: 'ES',
        languageCode: 'es'),
    // LanguageModel(
    //     imageUrl: '',
    //     languageName: 'Arabic',
    //     countryCode: 'SA',
    //     languageCode: 'ar'),
  ];
}
