import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:blackjack/services/local_storage.dart';

import '../utils/enum.dart';

class SoundController extends GetxController {
  final player = AudioPlayer();
  final isMuted = false.obs;
  final isVibrate = false.obs;

  @override
  void onInit() {
    getMute();
    super.onInit();
  }

  void getMute() {
    isMuted.value = LocalStorage.instance.read(StorageKey.mute.name) ?? false;
    muteUnmute();
  }

  void playSound() async {
    player.play(AssetSource('theme_soung.mp3'));
  }

  void muteUnmute() {
    if (isMuted.value) {
      player.setVolume(1.0); // Unmute the audio
    } else {
      player.setVolume(0.0); // Mute the audio
    }
    LocalStorage.instance.write(StorageKey.mute.name, isMuted.value);
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
