import 'package:flutter/material.dart';
import 'package:gemini_api_app/page/voice/animation/animation.dart';
import 'package:gemini_api_app/page/voice/controller.dart';
import 'package:get/get.dart';

class VoicePage extends GetView<VoiceController> {
  const VoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 90,
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            Image.asset('assets/logo.png', height: 100, width: 100),
            const Expanded(child: SizedBox(height: 100)),
            const Text(
              'Talk with Gemini',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(width: 30),
          ],
        ),
        const Expanded(
          child: CircleMovement(),
        )
        // IconButton(
        //   onPressed: controller.state.isListening.value
        //       ? controller.stopListening
        //       : controller.startListening,
        //   icon: Icon(
        //     controller.state.waitingForSpeech.value
        //         ? Icons.cancel
        //         : Icons.mic,
        //     color: controller.state.waitingForSpeech.value
        //         ? const Color.fromARGB(255, 204, 62, 1)
        //         : const Color.fromARGB(255, 0, 135, 116),
        //   ),
        //   iconSize: 90,
        // ),
        // const SizedBox(),
      ],
    )));
  }
}
