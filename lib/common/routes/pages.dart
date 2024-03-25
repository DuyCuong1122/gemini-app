import 'package:gemini_api_app/page/homepage/bindings.dart';
import 'package:gemini_api_app/page/homepage/view.dart';
import 'package:gemini_api_app/page/text/index.dart';
import 'package:gemini_api_app/page/text_with_image/index.dart';
import 'package:gemini_api_app/page/voice/index.dart';
import 'package:get/get.dart';

import 'names.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.Text,
        page: () => const TextPage(),
        binding: TextBinding()),
    GetPage(
        name: AppRoutes.TextWithImage,
        page: () => const TextWithImagePage(),
        binding: TextWithImageBinding()),
    GetPage(
        name: AppPages.APPlication,
        page: () => Homepage(),
        binding: HomepageBinding()),
    GetPage(
        name: AppRoutes.Voice,
        page: () => const VoicePage(),
        binding: VoiceBinding()),
  ];
}
