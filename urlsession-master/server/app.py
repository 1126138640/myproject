from flask import Flask, request, jsonify
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello, World!'


@app.route('/get', methods=['GET'])
def test_get():
    return jsonify(key='value')


@app.route('/post', methods=['POST'])
def test_post():
    json_data = request.get_json()
    print(json_data)
    return jsonify(key='value')
