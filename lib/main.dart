import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'api_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final record = AudioRecorder();
  String result = "No Answer Yet 😢";
  String? filePath;
  bool isRecording = false; // ✅ Declare here

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      Directory tempDir = await getTemporaryDirectory();
      filePath = "${tempDir.path}/audio.m4a";

      await record.start(const RecordConfig(), path: filePath!);
      setState(() {
        isRecording = true;
        result = "🎙️ Recording Started...";
      });
    }
  }
void stopRecording() async {
  if (await record.isRecording()) {
    await record.stop();
    print("Recording Stopped: $filePath");

    setState(() {
      isRecording = false;
      result = "⌛ Analyzing...";
    });

    var response = await ApiService.uploadAudio(filePath ?? "");
    print(response);

    if (response != "API Connection Error ❌" && response != "Server Error 😢") {
      var jsonData = response; // ✅ Direct Assignment

      int grammar = jsonData["grammar"] ?? 0; // 👌 Null ko 0 se Replace
      int fluency = jsonData["fluency"] ?? 0; // 🔥
      int pronunciation = jsonData["pronunciation"] ?? 0; // 🔥

      setState(() {
        result = """
🎯 **Transcription:** ${jsonData["transcription"]}
📝 **Grammar:** $grammar/10
💬 **Fluency:** $fluency/10
🔊 **Pronunciation:** $pronunciation/10
⭐ **Overall Band Score:** ${(grammar + fluency + pronunciation) ~/ 3}/10
""";
      });
    } else {
      setState(() {
        result = response.toString(); // ✅ Fix Type
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IELTS Speaking Bot 🤖"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isRecording ? null : startRecording,
              child: Text("🎙️ Start Recording"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : null,
              child: Text("⏹️ Stop Recording"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            SizedBox(height: 30),
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
