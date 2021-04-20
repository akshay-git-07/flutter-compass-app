import 'package:flutter_tts/flutter_tts.dart';

class SpeechAPI {
  final FlutterTts flutterTts = FlutterTts();

  setLanguage() async {
    await flutterTts.setLanguage('en-IN');
  }

  Future speak(String text) async {
    await flutterTts.speak(text);
  }

  Future setPitchRate({pitch = 0.8}) async {
    await flutterTts.setPitch(pitch);
  }

  Future stop() async {
    await flutterTts.stop();
  }
}
