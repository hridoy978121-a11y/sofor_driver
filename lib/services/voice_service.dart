import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool isListening = false;

  Future<bool> init() async {
    return await _speech.initialize();
  }

  void listen({required Function(String) onResult}) {
    isListening = true;
    _speech.listen(
      localeId: "bn_BD",
      onResult: (r) => onResult(r.recognizedWords),
    );
  }

  void stop() {
    isListening = false;
    _speech.stop();
  }

  Future<void> speak(String text) async {
    await _tts.setLanguage("bn-BD");
    await _tts.speak(text);
  }
}