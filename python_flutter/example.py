from flask import Flask, jsonify, send_file
import matplotlib.pyplot as plt
import io

app = Flask(__name__)

@app.route('/plot')
def plot():
    # Generate a plot using Matplotlib
    plt.figure()
    plt.plot([1, 2, 3], [4, 5, 6])
    plt.title("Sample Plot A")

    # Save plot to a BytesIO object
    img = io.BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)

    return send_file(img, mimetype='image/png')

if __name__ == '__main__':
    app.run(debug=True)
