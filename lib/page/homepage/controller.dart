import 'package:flutter/material.dart';
import 'package:gemini_api_app/page/homepage/state.dart';
import 'package:gemini_api_app/page/text/view.dart';
import 'package:gemini_api_app/page/text_with_image/view.dart';
import 'package:gemini_api_app/page/voice/view.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController {
  HomepageController();
  HomepageState state = HomepageState();

  final List<Widget> pages = [
    VoicePage(),
    TextPage(),
    TextWithImagePage(),
  ];

  void onItemTapped(int index) {
    state.selectedIndex.value = index;
  }
}
