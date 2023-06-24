from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    user = {"name": "Flask"}
    return render_template('index.html', title='Home', user=user)

if __name__ == '__main__':
    app.run(debug=True, threaded=True)

