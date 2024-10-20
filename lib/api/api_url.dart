class ApiUrl {
  // static String baseUrl = 'https://consumersnetworks.shop/api/v1/';
  static String baseUrl = 'https://www.consumersnetworks.com/api/v1/';
  static String loginUrl = '${baseUrl}auth/driverLogin';
  static String driverRegisterUrl = '${baseUrl}auth/driverRegister';
  static String resendOtpUrl ='${baseUrl}auth/resendOtp';
  static String verifyOtpUrl = '${baseUrl}auth/verifyOtp';
  static String forgotPasswordUrl = '${baseUrl}delivery-man/auth/forgot-password';
  static String verifyForgotOtpUrl = '${baseUrl}delivery-man/auth/verify-otp';
  static String resetPasswordUrl = '${baseUrl}delivery-man/auth/reset-password';
  static String getProfileUrl = '${baseUrl}delivery-man/info';
  static String getVehicleInfoUrl = '${baseUrl}delivery-man/vehicle-info?';
  static String updateProfileUrl = '${baseUrl}delivery-man/update-profile';
  static String updatePasswordUrl = '${baseUrl}delivery-man/update-password';
  static String earnUrl = '${baseUrl}delivery-man/earn';
  static String onlineUrl = '${baseUrl}delivery-man/is-online';
  static String allOrderUrl = '${baseUrl}delivery-man/all-orders';
  static String dashboardUrl = '${baseUrl}delivery-man/dashboard';
  static String updateFcmTokenUrl = '${baseUrl}delivery-man/update-fcm-token';
  static String currentOrderUrl = '${baseUrl}delivery-man/current-orders';
  static String acceptOrderUrl = '${baseUrl}delivery-man/accept-order';
  static String rejectOrderUrl = '${baseUrl}delivery-man/reject-order';
  static String upcomingOrderUrl = '${baseUrl}delivery-man/all-orders-request';
  static String notificationUrl = '${baseUrl}delivery-man/notifications';
  static String orderDetailsUrl = '${baseUrl}delivery-man/order-details?';
  static String updateOrderStatusUrl =
      '${baseUrl}delivery-man/update-order-status';
  static String updateVehicleInfoUrl = '${baseUrl}delivery-man/update-vehicle-info';
  static String updateLastLocationUrl = '${baseUrl}delivery-man/update-last-location';
  static String deleteAccountUrl = '${baseUrl}delivery-man/account-delete';
}
