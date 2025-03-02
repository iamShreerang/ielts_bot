from transformers import pipeline
import nltk
nltk.download("cmudict")
from nltk.corpus import cmudict

pron_dict = cmudict.dict()

def analyze(text):
    sentiment = pipeline("sentiment-analysis")
    result = sentiment(text)

    feedback = "Good Fluency!" if result[0]["label"] == "POSITIVE" else "Try to improve clarity."

    correct_words = sum([1 for word in text.split() if word.lower() in pron_dict])
    score = f"{correct_words}/{len(text.split())} Correct Pronunciation"

    return {"feedback": feedback, "score": score}
