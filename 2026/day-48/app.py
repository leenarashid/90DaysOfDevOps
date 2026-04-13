from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/health")
def health_check():
    return jsonify({"status": "ok", "message": "Flask app is running!"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
