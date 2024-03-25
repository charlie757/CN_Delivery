class ApiUrl {
  static String baseUrl = 'https://www.consumersnetworks.com/testing/api/v1/';
  static String loginUrl = '${baseUrl}auth/login';
  static String getProfileUrl = '${baseUrl}delivery-man/info';
  static String updateProfileUrl = '${baseUrl}delivery-man/update-info';
  static String updatePasswordUrl = '${baseUrl}delivery-man/update-password';
  static String earnUrl = '${baseUrl}delivery-man/earn';
  static String onlineUrl = '${baseUrl}delivery-man/is-online';
  static String allOrderUrl = '${baseUrl}delivery-man/all-orders';
  static String dashboardUrl = '${baseUrl}delivery-man/dashboard';
  static String updateFcmTokenUrl = '${baseUrl}delivery-man/update-fcm-token';
  static String currentOrderUrl = '${baseUrl}delivery-man/current-orders';
  static String notificationUrl = '${baseUrl}delivery-man/notifications';
  static String orderDetailsUrl = '${baseUrl}delivery-man/order-details?';
  static String updateOrderStatusUrl =
      '${baseUrl}delivery-man/update-order-status';
}
