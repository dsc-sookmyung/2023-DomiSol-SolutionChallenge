import 'package:flutter/material.dart';
import 'package:flutter_/screens/voice_recoder.display.dart';

class VoiceRecorderScreen extends StatefulWidget {
  const VoiceRecorderScreen({Key? key}) : super(key: key);

  @override
  _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
}

class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VoiceRecoderDisplay());
  }
}
