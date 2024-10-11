import 'package:cn_delivery/localization/language_constrants.dart';
import 'package:cn_delivery/utils/utils.dart';

class AppValidation {
  static String? firstNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_first_name', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? lastNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_last_name', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? phoneNumberValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_phone_number', navigatorKey.currentContext!)!;
    } else if (val.length < 10) {
      return getTranslated( 'enter_valid_phone_number', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? emailValidator(val) {
    RegExp regExp = RegExp(Utils.emailPattern.trim());
    if (val.isEmpty) {
      return getTranslated( 'enter_email', navigatorKey.currentContext!)!;
    } else if (!regExp.hasMatch(val)) {
      return getTranslated( 'enter_valid_email', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? passwordValidator(val) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (val.isEmpty) {
      return getTranslated( 'enter_password', navigatorKey.currentContext!)!;
    }
     else if (val.length<6) {
      return getTranslated( 'passwordLenghtValidation', navigatorKey.currentContext!)!;
    }
     else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? reEnterpasswordValidator(currentValue, previousValue) {
    RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (currentValue.isEmpty) {
      return getTranslated( 'enter_password', navigatorKey.currentContext!)!;
    } else if (currentValue.length<6) {
      return getTranslated( 'passwordLenghtValidation', navigatorKey.currentContext!)!;
    } else if (previousValue.isNotEmpty) {
      if (currentValue != previousValue) {
        return getTranslated( 'password_same', navigatorKey.currentContext!)!;
      }
      return null;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? addressValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_your_address', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? cityValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_city', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? stateValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_state', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? countryValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_country', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? stateIdValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_state_id', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }


  static String? vehicleNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_vehicle_name', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? vehicleBrandValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_brand_name', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  
  static String? vehicleSizeValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_vehicle_size', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  
  static String? vehicleColorValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_vehicle_color', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }
  static String? vehicleTypeValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'select_vehicle_type_validation', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }
  static String? modelNumberValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_model_number', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }static String? dateOfManufactureValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'select__manufacture_date', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }
  static String? dateOfRegistrationValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'select_registration_date', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? fuelTypeValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'select_fuel_type_validation', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }


  static String? vehicleRegistrationValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_registration_number', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

   static String? vehicleLicenseValidator(val) {
    if (val.isEmpty) {
      return getTranslated( 'enter_licence_number', navigatorKey.currentContext!)!;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

}
