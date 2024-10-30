import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackjack/utils/color_const.dart';
import 'package:blackjack/utils/enum.dart';
import 'package:blackjack/views/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'language/languages.dart';
import 'services/local_storage.dart';
import 'utils/global.dart';

void main() async {
  await LocalStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.zh.name;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Football Live Score',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: secondaryColor,
          ),
          // theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.system,
          translations: Languages(),
          locale: Global.language == Language.zh.name
              ? const Locale('zh', 'CN')
              : Global.language == Language.vi.name
                  ? const Locale('vi', 'VN')
                  : Global.language == Language.ko.name
                      ? const Locale('ko', 'KR')
                      : Global.language == Language.hi.name
                          ? const Locale('hi', 'IN')
                          : const Locale('en', 'US'),
          fallbackLocale: const Locale('zh', 'CN'),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
