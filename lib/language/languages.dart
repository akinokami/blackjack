import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'en_language.dart';
import 'hindi_language.dart';
import 'ko_language.dart';
import 'vi_language.dart';
import 'zh_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': ZhLanguage().zhLanguage,
        'en_US': EnLanguage().enLanguage,
        'hi_IN': HiLanguage().hiLanguage,
        'vi_VN': ViLanguage().viLanguage,
        'ko_KR': KoLanguage().koLanguage,
      };
}
