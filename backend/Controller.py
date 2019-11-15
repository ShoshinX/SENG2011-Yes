from BloodBank import BloodBank
from Notification import Notification
from Logs import Logs
from BloodRecord import BloodRecord

class Controller():
    def __init__(self):
        self.notif = Notification()
        self.log = Logs()
        self.bloodBank = BloodBank()
    
    def addBR(self,bloodType, Location, day1, month1, year1, day2, month2, year2, isOkay):
        #TODO Add the logs and notif triggers
        self.bloodBank.Push(bloodType,BloodRecord(bloodType,Location,day1,month1,year1,day2,month2,year2,isOkay))
        #TODO what about returning a message about the Blood levels being too low?
    #TODO log and Notif
    #def ViewNotif(self):
    def ViewLog(self):
        return self.log.log
    def ViewBR(self):
        # transform BloodRecords into Strings
        return self.bloodBank.ViewAll() 
    def ViewBRLevels(self):
        return self.bloodBank.ViewBRLevels()
    def RequestBR(self, bloodType):
        #TODO implement the blood matching algorithm
        return self.bloodBank.Qop(bloodType)