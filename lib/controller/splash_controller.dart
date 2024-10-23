import 'package:get/get.dart';
import '../views/screens/game/play_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const PlayScreen()); //BottomNavMenu() //PlayScreen()
    });
    super.onInit();
  }
}
