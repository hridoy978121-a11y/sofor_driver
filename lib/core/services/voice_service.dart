import 'package:speech_to_text/speech_to_text.dart';
class VoiceService {
  final SpeechToText _speech = SpeechToText();
  Future<bool> init() async => await _speech.initialize();
  void listen({required Function(String) onResult}) {
    _speech.listen(
      localeId: 'bn_BD',
      onResult: (r) => onResult(r.recognizedWords.toLowerCase()),
    );
  }
  void stop() => _speech.stop();
}