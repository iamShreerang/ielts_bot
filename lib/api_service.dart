import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> uploadAudio(String filePath) async {
    var uri = Uri.parse("http://192.168.116.239:5000/predict");
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('audio', filePath));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"error": "Server Error 😢"};
      }
    } catch (e) {
      return {"error": "API Connection Error ❌"};
    }
  }
}

