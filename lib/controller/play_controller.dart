import 'dart:async';

import 'package:get/get.dart';

import '../services/local_storage.dart';
import '../utils/enum.dart';

class PlayController extends GetxController {
  final balance = 50000.obs;

  @override
  void onInit() {
    getBalance();
    super.onInit();
  }

  void getBalance() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      balance.value =
          LocalStorage.instance.read(StorageKey.balance.name) ?? 50000;
    });
  }
}
