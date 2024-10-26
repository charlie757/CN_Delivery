// ignore_for_file: non_constant_identifier_names

import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/model/language_model.dart';
import 'package:cn_delivery/utils/enum.dart';
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
  static bool is401Error = false;

  /// true if logout it and false if relogin

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
  ];

  static String statusTitle(String state) {
    if (state.toLowerCase() == 'accepted') {
      return getTranslated('accepted', navigatorKey.currentContext!)!;
    } else if (state.toLowerCase() == 'out_for_pickup') {
      return getTranslated('outForPickup', navigatorKey.currentContext!)!;
    } else if (state.toLowerCase() == 'picked') {
      return getTranslated('picked', navigatorKey.currentContext!)!;
    } else if (state.toLowerCase() == 'out_for_delivery') {
      return getTranslated('outForDelivery', navigatorKey.currentContext!)!;
    } else if (state.toLowerCase() == 'delivered') {
      return getTranslated('delivered', navigatorKey.currentContext!)!;
    }

    return '';
  }

  static orderStatusTitle(String status) {
    if (status.toLowerCase() ==
        OrderStatusTypes.delivery_person_assigned.name) {
      return getTranslated('order_prepration', navigatorKey.currentContext!);
    } else if (status.toLowerCase() == OrderStatusTypes.processing.name) {
      return getTranslated('order_ready_for_pickup', navigatorKey.currentContext!);
    }
    else if(status.toLowerCase() == OrderStatusTypes.delivered.name){
      return getTranslated('check_status', navigatorKey.currentContext!);
    }
    else{
      return getTranslated('change_status', navigatorKey.currentContext!);
    }
    
  }

  static checkOrderStatus(String status) {
    if (status.toLowerCase() == OrderStatusTypes.accepted.name) {
      return true;
    } else if (status.toLowerCase() ==
        OrderStatusTypes.delivery_person_assigned.name) {
      return true;
    } else if (status.toLowerCase() == OrderStatusTypes.processing.name) {
      return true;
    } else if (status.toLowerCase() ==
        OrderStatusTypes.order_ready_for_pickup.name) {
      return true;
    } else if (status.toLowerCase() ==
        OrderStatusTypes.order_picked_up_by_delivery_person.name) {
      return true;
    } else if (status.toLowerCase() == OrderStatusTypes.delivered.name) {
      return true;
    } else {
      return false;
    }
  }

  static changeOrderStatusColor(String status, int index) {
    if ((index == 1) &&
        (status.toLowerCase() == OrderStatusTypes.processing.name ||
            status.toLowerCase() ==
                OrderStatusTypes.order_ready_for_pickup.name ||
            status.toLowerCase() == OrderStatusTypes.delivered.name ||
            status.toLowerCase() ==
                OrderStatusTypes.order_picked_up_by_delivery_person.name)) {
      return true;
    } else if ((index == 2) &&
        (status.toLowerCase() == OrderStatusTypes.order_ready_for_pickup.name ||
            status.toLowerCase() == OrderStatusTypes.delivered.name ||
            status.toLowerCase() ==
                OrderStatusTypes.order_picked_up_by_delivery_person.name)) {
      return true;
    } else if ((index == 3) &&
        (status.toLowerCase() == OrderStatusTypes.delivered.name ||
            status.toLowerCase() ==
                OrderStatusTypes.order_picked_up_by_delivery_person.name)) {
      return true;
    } else if (index == 4 &&
        status.toLowerCase() == OrderStatusTypes.delivered.name) {
      return true;
    }
    return false;
  }
}
