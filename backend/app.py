from flask import Flask, request, jsonify
from flask_cors import CORS
import whisper
import os
from phonemizer import phonemize
from phonemizer.backend import EspeakBackend

app = Flask(__name__)
CORS(app)  # CORS Enable Kiya

UPLOAD_FOLDER = "audio"
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)


def get_pronunciation(text):
    backend = EspeakBackend(language='en')
    pronunciation = phonemize(text, backend=backend)
    return pronunciation


@app.route("/predict", methods=["POST"])
def predict():
    if "audio" not in request.files:
        return jsonify({"error": "No audio file found"})

    audio_file = request.files["audio"]
    file_path = os.path.join(UPLOAD_FOLDER, "audio.wav")
    audio_file.save(file_path)

    model = whisper.load_model("base")
    result = model.transcribe(file_path)

    text = result["text"]
    pronunciation = get_pronunciation(text)

    return jsonify({
        "text": text,
        "pronunciation": pronunciation
    })


if __name__ == "__main__":
    app.run(debug=True, port=5000)
