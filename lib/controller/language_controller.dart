import 'package:flutter/material.dart';
import 'package:blackjack/utils/enum.dart';
import 'package:get/get.dart';

import '../services/local_storage.dart';

class LanguageController extends GetxController {
  final language = ''.obs;

  @override
  void onInit() {
    getLanguage();
    super.onInit();
  }

  void changeLanguage(String languageCode, String countryCode) {
    language.value = languageCode;

    Get.updateLocale(Locale(languageCode, countryCode));
    LocalStorage.instance.write(StorageKey.language.name, languageCode);
  }

  void getLanguage() {
    language.value = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.en.name;
  }
}
