from BloodBank import BloodBank
from Notification import Notification
from Log import Log
from BloodRecord import BloodRecord

class Controller():
    def __init__(self):
        self.notif = Notification()
        self.log = Log()
        self.bloodBank = BloodBank()
    
    #TODO
    def addBR(self,bloodType, Location, day1, month1, year1, day2, month2, year2, isOkay):
        #TODO deal with bloodType enumeration
        self.bloodBank.Push(bloodType,BloodRecord(bloodType,Location,day1,month1,year1,day2,month2,year2,isOkay))
        #TODO log and Notif
    #def ViewNotif():
    #def ViewLog():
    #def ViewBR():
    #def ViewBRLevels():