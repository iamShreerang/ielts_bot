import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FlutterSoundRecorder? _recorder;
  bool isRecording = false;
  String? audioPath;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder!.openAudioSession();
    await Permission.microphone.request();
  }

  Future<void> startRecording() async {
    try {
      audioPath = 'audio_${DateTime.now().millisecondsSinceEpoch}.wav';
      await _recorder!.startRecorder(toFile: audioPath);
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print("Recording Error: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? filePath = await _recorder!.stopRecorder();
      setState(() {
        isRecording = false;
        audioPath = filePath;
      });
      if (filePath != null) {
        uploadAudio(filePath);
      }
    } catch (e) {
      print("Stop Error: $e");
    }
  }

  Future<void> uploadAudio(String path) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://127.0.0.1:8000/upload/"));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Audio Uploaded Successfully");
      setState(() {
        messages.add({"text": "Audio Transcribed ✅", "isUser": false});
      });
    } else {
      print("Upload Failed");
    }
  }

  @override
  void dispose() {
    _recorder!.closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IELTS Bot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (ctx, index) {
                return Align(
                  alignment: messages[index]['isUser']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: messages[index]['isUser']
                          ? Colors.blueAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]['text']),
                  ),
                );
              },
            ),
          ),
          if (isRecording)
            Center(child: CircularProgressIndicator()),

          // Recording Button
          IconButton(
            icon: Icon(isRecording ? Icons.stop : Icons.mic),
            color: Colors.blueAccent,
            onPressed: () {
              if (isRecording) {
                stopRecording();
              } else {
                startRecording();
                setState(() {
                  messages.add({"text": "Recording...", "isUser": true});
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
