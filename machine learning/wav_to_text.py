import speech_recognition as sr
from pydub import AudioSegment
from flask import Flask, request, jsonify
import requests
import json
import re
import collections
import time
import os

app = Flask(__name__)

def add_board_id(data, board_id):
    return [{"boardId": board_id, "word": d['word'], "frequency": d['frequency']} for d in data]

@app.route('/api/boards/test', methods=['GET'])
def get_word_frequency():
    r = sr.Recognizer()

    # Get the audio file from Flutter
    audio_file = request.files['audio']
    
    audio_file.export("recording.wav", format="wav")
    recording_file = sr.AudioFile('recording.wav')

    with recording_file as source:
        audio = r.record(source)
        
    result_trans = []
    result_trans.append(r.recognize_google(audio, language='ko'))
    words = []
    for sentence in result_trans:
        words.extend(re.findall(r'\b\w+\b', sentence))
        
    result_word_freq = collections.Counter(words)
    
    # print(result_word_freq)
    
    data = [{"word": key, "frequency": value} for key, value in result_word_freq.items()]

    # Get the boardId from Flutter (replace this with your code to receive the boardId)
    board_id_from_flutter = request.json.get('boardId')
    
    data_with_board_id = add_board_id(data, board_id_from_flutter)
    # print(data_with_board_id)

    # (replace this with the code to send the response in your application)
#     print(response)
    headers = {"Content-Type": "application/json"}
    data_json = json.dumps(data_with_board_id)
    
    try:
        time.sleep(10)
        response = requests.get("http://{}}/api/boards/test".format(os.environ.get("spring_server")), data = data_json, headers=headers)
        response.raise_for_status() # Raise an exception for 4xx and 5xx HTTP status codes
        return response.json()
    except requests.exceptions.RequestException as e:
        return {"error": str(e)}
        
if __name__ == "__main__":
    app.run(debug=True, use_reloader=False)
