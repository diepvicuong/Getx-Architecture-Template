class AppSetting {
  static const String appTitle = 'App Name';

  // Network
  static const baseUrl = '';
  static const requestTimeout = 10; //seconds
  static const bool requireCheckToken = false;

  // API parameters
  static const statusExpired = 'ExpiredJwtToken';

  // UI related
  static const int dialogContentMaxLine = 3;

  // Regex
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
