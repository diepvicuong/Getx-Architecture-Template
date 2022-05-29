import '../config/app_setting.dart';

extension Validator on String {
  bool get isValidEmail => AppSetting.emailRegExp.hasMatch(this);
}
