import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gemini_api_app/common/config/api.dart';
import 'package:gemini_api_app/page/voice/state.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;

class VoiceController extends GetxController {
  VoiceController();
  VoiceState state = VoiceState();
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final textController = TextEditingController();
  final GenerativeModel model =
      GenerativeModel(model: 'gemini-pro', apiKey: API_key);
  RxString wordSpoken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initSpeech();
    initLanguageDetect();
  }

  initSpeech() async {
    state.speechEnabled.value = await speechToText.initialize();
  }

  initLanguageDetect() async {
    await langdetect.initLangDetect();
  }

  sendTextToGemini(String text) async {
    final response = await model.generateContent([Content.text(text)]);
    print("Generated text: ${response.text.toString()}");
    state.geminiText.value = response.text.toString();
    await flutterTts.setLanguage(state.language.value);
    state.geminiSpeech.value = true;
    await flutterTts.speak(response.text.toString());
    flutterTts.setCompletionHandler(() {
      state.geminiSpeech.value = false;
      startListening();
    });
  }

  void startListening() async {
    if (state.speechEnabled.value) {
      await speechToText.listen(
        onResult: onSpeechResult,
        localeId: 'vi_VN, en_US',
      );
      state.isListening.value = true;
      state.waitingForSpeech.value = false;
    } else {
      print('Error: SpeechToText not initialized successfully');
    }
  }

  onSpeechResult(result) {
    wordSpoken.value = "${result.recognizedWords}";
    if (result.finalResult) {
      state.text.value = result.recognizedWords;
      if (langdetect.detect(state.text.value) == 'en') {
        state.language.value = 'en_US';
        state.text.value = 'Say in summary ${state.text.value}';
      } else if (langdetect.detect(state.text.value) == 'vi') {
        state.language.value = 'vi_VN';
        state.text.value = 'Nói tóm tắt ${state.text.value}';
      }
      print("Recognized text: ${state.text.value}");
      state.isListening.value = false;
      state.waitingForSpeech.value = true;
      sendTextToGemini(state.text.value);
    }
  }

  stopListening() async {
    await speechToText.stop();
    state.isListening.value = false;
    state.waitingForSpeech.value = false;
    stopGeminiSpeech();
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  stopGeminiSpeech() async {
    if (state.geminiSpeech.value) {
      await flutterTts.stop();
      state.geminiSpeech.value = false;
    }
  }
}
