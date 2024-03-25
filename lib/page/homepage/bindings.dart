import 'package:gemini_api_app/page/text/controller.dart';
import 'package:gemini_api_app/page/text_with_image/controller.dart';
import 'package:gemini_api_app/page/voice/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomepageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageController>(() => HomepageController());
    Get.lazyPut<TextController>(() => TextController());
    Get.lazyPut<TextWithImageController>(() => TextWithImageController());
    Get.lazyPut<VoiceController>(() => VoiceController());
  }
}
