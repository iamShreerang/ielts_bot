import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api_service.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  bool isRecording = false;

  Future<void> startRecording() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await recorder.openRecorder();
      await recorder.startRecorder(toFile: 'audio.wav');
      setState(() => isRecording = true);
    }
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();
    setState(() => isRecording = false);
    await ApiService.uploadAudio('audio.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IELTS Bot')),
      body: Center(
        child: ElevatedButton(
          onPressed: isRecording ? stopRecording : startRecording,
          child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
        ),
      ),
    );
  }
}
