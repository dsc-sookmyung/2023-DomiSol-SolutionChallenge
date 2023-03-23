import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceRecoderDisplay extends StatefulWidget {
  const VoiceRecoderDisplay({Key? key}) : super(key: key);

  @override
  _VoiceRecoderDisplayState createState() => _VoiceRecoderDisplayState();
}

class _VoiceRecoderDisplayState extends State<VoiceRecoderDisplay> {
  FlutterSoundPlayer? _player = FlutterSoundPlayer();
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  bool _isPlayerInited = false;
  bool _isRecorderInited = false;
  bool _isPlaybackReady = false;
  final String _path = 'package:flutter_/assets/records/voice_recorder_example.acc';

  @override
  void initState() {
    super.initState();

    _player!.openPlayer().then((value) => setState(() {
          _isPlayerInited = true;
        }));

    _openTheRecord();
  }

  @override
  void dispose() {
    super.dispose();

    _player!.closePlayer();
    _player = null;
    _recorder!.closeRecorder();
    _recorder = null;
  }

  void _openTheRecord() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('녹음 권한이 없습니다.');
      }
    }
    await _recorder!.openRecorder();
    _isRecorderInited = true;
  }

  void _record() {
    _recorder!.startRecorder(toFile: _path).then((value) => setState(() {}));
  }

  void _stopRecorder() async {
    await _recorder!.stopRecorder().then((value) => setState(() {
          _isPlaybackReady = true;
        }));
  }

  void _play() {
    assert(_isPlayerInited &&
        _isPlaybackReady &&
        _recorder!.isStopped &&
        _player!.isStopped);
    _player!.startPlayer(fromURI: _path, whenFinished: () => setState(() {}));
  }

  void _stopPlayer() {
    _player!.stopPlayer().then((value) => setState(() {}));
  }

  void _getRecorder() {
    if (!_isRecorderInited || !_player!.isStopped) {
      return;
    }
    _recorder!.isStopped ? _record() : _stopRecorder();
  }

  void _getPlayback() {
    if (!_isPlayerInited || !_isPlaybackReady || !_recorder!.isStopped) {
      return;
    }
    _player!.isStopped ? _play() : _stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(50),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _getRecorder();
                },
                icon: Icon(_recorder!.isRecording ? Icons.stop : Icons.circle),
                color: _recorder!.isRecording ? Colors.grey : Colors.red,
              ),
              Text(_recorder!.isRecording ? '녹음 중입니다' : '버튼을 누르면 녹음됩니다')
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(50),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _getPlayback();
                },
                icon: Icon(_player!.isPlaying ? Icons.stop : Icons.play_arrow),
                color: _player!.isPlaying ? Colors.grey : Colors.red,
              ),
              Text(_player!.isPlaying ? '재생 중입니다' : '버튼을 누르면 재생됩니다')
            ],
          ),
        )
      ],
    );
  }
}
