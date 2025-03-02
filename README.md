
### 🎯 **IELTS Audio Bot**  
A Speech-to-Text based IELTS Practice Application using Flutter & FastAPI  

---

## 📌 Overview
IELTS Audio Bot is an AI-based app that helps users practice **IELTS Speaking** by recording their answers to various questions and converting the speech into text. The app provides instant feedback on the recorded audio to improve user performance.

---

## 🛠️ Tech Stack
### Frontend:
- Flutter (Audio Recording + HTTP API Calls)
- Dart

### Backend:
- FastAPI
- SpeechRecognition API
- Python

---

## 🎯 Features
- Audio Recording 🎙️
- Automatic Speech-to-Text Conversion
- Instant Feedback System
- API Integration
- Simple UI for Practice

---

## 📌 Folder Structure
```
├── lib/
│   ├── main.dart           # Entry Point
│   ├── screens/
│   │   └── home_screen.dart # Main UI Screen
│   ├── services/
│   │   └── api_service.dart # API Integration
│   └── widgets/
│       └── record_button.dart # Audio Record Button
└── pubspec.yaml            # Dependencies
```

---

## 🔑 Installation
### Clone the Repository
```bash
git clone https://github.com/iamShreerang/ielts_bot.git
cd IELTS-Bot
```

### Install Dependencies
```bash
flutter pub get
```

### Run the App
```bash
flutter run
```

---

## 🌐 API Configuration
Modify the **API URL** in:
```dart
String apiUrl = "http://10.0.2.2:5000/record_audio";
```

---

## 🔥 API Response
### Example Request:
```dart
{
  "audio": "audio_file.wav"
}
```

### Example Response:
```json
{
  "transcript": "My name is Shreerang Kolhe and I want to study abroad.",
  "score": 8.0
}
```

---

## 🎯 How It Works
1. Press the **Record Button** 🎙️
2. Audio will be recorded
3. Audio is sent to the FastAPI backend
4. Backend converts Audio → Text
5. Response will be shown on the screen

---

## 🚀 Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
  audioplayers: ^1.0.1
  record: ^4.4.4
```

---

## 📌 Future Scope
- Grammar Correction
- Speaking Score Prediction (Bands)
- Multilingual Support
- User Authentication

---

## 💪 Contributed by
| Name               | Role                  |
|----------------|-----------------------|
| Shreerang Kolhe | Developer & Backend |

---

## 📌 How to Contribute
1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Create a Pull Request

---

## 📄 License
This project is licensed under the **MIT License**.

---

### 🎯 Contact
LinkedIn: [Shreerang Kolhe](https://www.linkedin.com/in/iamshreerang)  
Email: shreekolhe03@gmail.com  

---

If you like this project, don't forget to 🌟 the repo! 😊
