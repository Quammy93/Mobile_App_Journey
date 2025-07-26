import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceInputButton extends StatefulWidget {
  final Function(String) onResult;

  const VoiceInputButton({
    super.key,
    required this.onResult,
  });

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (val) => setState(() => _isListening = val == 'listening'),
      onError: (val) => setState(() => _isListening = false),
    );
    setState(() => _isAvailable = available);
  }

  void _startListening() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required for voice input'),
        ),
      );
      return;
    }

    if (_isAvailable && !_isListening) {
      await _speech.listen(
        onResult: (val) {
          if (val.finalResult) {
            widget.onResult(val.recognizedWords);
          }
        },
        listenFor: const Duration(seconds: 10),
        pauseFor: const Duration(seconds: 3),
      );
    }
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isAvailable
          ? (_isListening ? _stopListening : _startListening)
          : null,
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening ? Colors.red : null,
      ),
      tooltip: _isListening ? 'Stop listening' : 'Voice input',
    );
  }
}