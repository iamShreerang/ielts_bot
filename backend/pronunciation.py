import phonemizer
from phonemizer import phonemize
import whisper
import jiwer

def transcribe_audio(audio_path):
    model = whisper.load_model("base")
    result = model.transcribe(audio_path)
    return result["text"]

def get_phonemes(text):
    phonemes = phonemize(text, language="en-us")
    return phonemes

def calculate_pronunciation_score(transcribed_text, expected_text):
    reference_phoneme = get_phonemes(expected_text)
    hypothesis_phoneme = get_phonemes(transcribed_text)

    wer = jiwer.wer(reference_phoneme, hypothesis_phoneme)
    pronunciation_score = round((1 - wer) * 10, 2)  # 0-10 Band Scale
    return pronunciation_score
