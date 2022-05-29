import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  FlutterSecureStorage _storage = FlutterSecureStorage();
}
