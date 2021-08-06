from flask import Flask
from flask_restful import Api, Resource, reqparse, abort
from flask_cors import CORS


import scheduleManager.scheduleManager

app = Flask(__name__)
CORS(app)

api = Api(app)



if __name__ == '__main__':
    app.run(debug = True, host = '0.0.0.0')


