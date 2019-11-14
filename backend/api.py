from flask import Flask, request 
from flask_restful import reqparse, abort, Api, Resource
from Controller import Controller
from BloodType import BloodType
from datetime import date

app = Flask(__name__)
api = Api(app)

parser = reqparse.RequestParser()
# create logic object here
controller = Controller();

class ViewLog(Resource):
    def get(self):
        return
class ViewBR(Resource):
    def get(self):
        return {'BloodRecords': controller.ViewBR() }, 200
class ViewBRLevels(Resource):
    def get(self):
        # [A,B,AB,O]
        return {'BloodRecordsLevels':controller.ViewBRLevels()}, 200
class ViewNotif(Resource):
    def get(self):
        return
class AddBR(Resource):
    def post(self):
        json_data = request.get_json()
        # extract data
        bt = json_data['BloodType']
        loc = json_data['Location']
        ProdDate = date.fromisoformat(json_data['ProdDate'])
        ExpDate = date.fromisoformat(json_data['ExpDate'])
        isOkay = json_data['IsOkay']
        # add into blood record
        controller.addBR(BloodType.FromStrToEnum(bt), loc, 
            ProdDate.day, ProdDate.month, ProdDate.year,
            ExpDate.day, ExpDate.month, ExpDate.year, isOkay)
        return 'successfully added new BloodRecord', 200
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