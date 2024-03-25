import 'package:get/get.dart';

class VoiceState {
  RxBool isListening = false.obs;
  RxString text = "".obs;
  RxBool waitingForSpeech = false.obs;
  RxBool speechEnabled = false.obs;
  RxBool geminiSpeech = false.obs;
  RxString language = "".obs;
  RxString geminiText = "".obs;
}
