import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/languages/en.dart';
import '../config/languages/ja.dart';

class LocalizationService extends Translations {
  static late String currentLanguage;

  static Future initialize() async {
    // TODO: Get currentLanguage in local storage
    currentLanguage = langCodes[1];
  }

// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage(langCode: currentLanguage);

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('ja');

// language code của những locale được support
  static final langCodes = [
    'en',
    'ja',
  ];

// Supported Locales
  static const locales = [
    Locale('en', 'US'),
    Locale('ja', 'JP'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'ja': '日本語',
  });

  // Use this function to change language if you don't want to depend on system locale
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    if (locale != null) {
      Get.updateLocale(locale);
      // TODO: Save currentLanguage in local storage
      currentLanguage = langCode;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ja_JP': ja,
      };

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }

  static Locale getLocaleByCurrentLanguage() {
    for (int i = 0; i < langCodes.length; i++) {
      if (currentLanguage == langCodes[i]) return locales[i];
    }

    return locales[1];
  }
}
