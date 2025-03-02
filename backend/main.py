from fastapi import FastAPI, UploadFile
import shutil
import speech_to_text
import evaluate

app = FastAPI()

@app.post("/upload/")
async def upload_audio(file: UploadFile):
    file_path = f"temp/{file.filename}"
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    text = speech_to_text.convert_audio(file_path)
    feedback = evaluate.analyze(text)

    return {"transcript": text, "feedback": feedback}
