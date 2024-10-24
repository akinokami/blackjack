import 'package:blackjack/utils/enum.dart';
import 'package:get/get.dart';

import '../services/local_storage.dart';

class HistoryController extends GetxController {
  final isLoading = false.obs;
  var history = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    getHistory();
    super.onInit();
  }

  void getHistory() {
    isLoading.value = true;
    history.value = List<Map<String, dynamic>>.from(
            LocalStorage.instance.read(StorageKey.history.name) ?? [])
        .reversed
        .toList();

    isLoading.value = false;
  }
}
