import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TmpRecordScreen extends StatefulWidget {
  TmpRecordScreen({Key? key}) : super(key: key);

  @override
  _TmpRecordScreenState createState() => _TmpRecordScreenState();
}

class _TmpRecordScreenState extends State<TmpRecordScreen> {
  String viewTxt = "Recorde Player";

  FlutterSoundRecorder? myRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer? myPlayer = FlutterSoundPlayer();
  bool check = false;
  bool playCheck = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      myRecorder = await FlutterSoundRecorder().openRecorder();
      myPlayer = await FlutterSoundPlayer().openPlayer();
    });
  }

  @override
  void dispose() {
    if (myRecorder != null) {
      myRecorder!.closeRecorder();
      myPlayer!.closePlayer();

      myRecorder = null;
      myPlayer = null;
    }
    super.dispose();
  }

  Future<void> _recodeFunc() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw RecordingPermissionException("Microphone permission not granted");
    setState(() {
      viewTxt = "Recoding ~";
    });
    if (!check) {
      Directory tempDir = await getTemporaryDirectory();
      File outputFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      await myRecorder!
          .startRecorder(toFile: outputFile.path, codec: Codec.aacADTS);
      print("START");
      setState(() {
        check = !check;
      });
      return;
    }
    print("STOP");
    setState(() {
      check = !check;
      viewTxt = "await...";
    });
    await myRecorder!.stopRecorder();
    return;
  }

  Future<void> playMyFile() async {
    if (!playCheck) {
      Directory tempDir = await getTemporaryDirectory();
      File inFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      try {
        Uint8List dataBuffer = await inFile.readAsBytes();
        print("dataBuffer $dataBuffer");
        setState(() {
          playCheck = !playCheck;
        });
        await this.myPlayer!.startPlayer(
            fromDataBuffer: dataBuffer,
            codec: Codec.aacADTS,
            whenFinished: () {
              debugPrint('Play finished');
              setState(() {});
            });
      } catch (e) {
        debugPrint(" NO Data");
      }
      return;
    }
    await myPlayer!.stopPlayer();
    setState(() {
      playCheck = !playCheck;
    });
    print("PLAY STOP!!");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('record'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              viewTxt,
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  _recodeFunc();
                  debugPrint('clicked');
                },
                tooltip: 'Increment',
                child: check ? Icon(Icons.stop) : Icon(Icons.play_arrow),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  Text("Play Controller\n(Recorde File)"),
                  IconButton(
                    icon: playCheck
                        ? Icon(Icons.stop)
                        : Icon(Icons.play_circle_filled),
                    onPressed: () async {
                      await playMyFile();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
