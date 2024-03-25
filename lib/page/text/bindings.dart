import 'package:gemini_api_app/page/text/controller.dart';
import 'package:get/get.dart';

class TextBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextController>(() => TextController());
  }
}
