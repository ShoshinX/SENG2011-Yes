from flask import Flask 
from flask_restful import reqparse, abort, Api, Resource
from Controller import Controller

app = Flask(__name__)
api = Api(app)

# create logic object here
controller = Controller();

class ViewLog(Resource):
    def get(self):
        return
class ViewBR(Resource):
    def get(self):
        return
class ViewBRLevels(Resource):
    def get(self):
        # [A,B,AB,O]
        return {'BloodRecordsLevels':controller.ViewBRLevels()}, 200
class ViewNotif(Resource):
    def get(self):
        return
class AddBR(Resource):
    def post(self):
        return
class RequestBR(Resource):
    def get(self):
        return

api.add_resource(ViewLog,'/api/viewLog')
api.add_resource(ViewBR,'/api/viewBR')
api.add_resource(ViewBRLevels,'/api/viewBRLevels')
api.add_resource(AddBR,'/api/addBR')
api.add_resource(RequestBR,'/api/requestBR')


if __name__ == "__main__":
    app.run(debug=True)