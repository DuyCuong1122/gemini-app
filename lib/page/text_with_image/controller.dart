import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini_api_app/common/config/api.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class TextWithImageController extends GetxController {
  TextWithImageController();
  var state = TextWithImageState();
  List textAndImageChat = [];
  List textWithImageChat = [];

  final ImagePicker picker = ImagePicker();

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Create Gemini Instance
  final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: API_key);

  // Text only input
  Future<void> fromTextAndImage(
      {required String query, required File image}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    {
      state.loading.value = true;
      textAndImageChat.add({
        "role": "User",
        "text": query,
        "image": image,
      });
      textController.clear();
      state.imageFile.value = null;
    }
    scrollToTheEnd();

    final imageBytes = await pickedFile.readAsBytes();

    final prompt = TextPart(query);
    final imagePart = DataPart('image/jpeg', imageBytes);
    await model.generateContent([
      Content.multi([prompt, imagePart])
    ]).then((value) {
      {
        state.loading.value = false;
        textAndImageChat
            .add({"role": "Gemini", "text": value.text, "image": ""});
      }
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      {
        state.loading.value = false;
        textAndImageChat
            .add({"role": "Gemini", "text": error.toString(), "image": ""});
      }
      scrollToTheEnd();
    });
    // print(response.text);
  }

  void scrollToTheEnd() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
}
