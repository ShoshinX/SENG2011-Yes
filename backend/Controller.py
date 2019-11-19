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
        self.bloodBank.Push(bloodType,BloodRecord(bloodType,Location,day1,month1,year1,day2,month2,year2,isOkay))
        self.log.addLog("addBloodRecord", "Added Blood Record: {}, {}-{}-{}, {}-{}-{}, {}".format(bloodType.name, year1, month1, day1, year2, month2, day2, Location), "success")
        if(self.bloodBank.BelowThreshold(1)):
            self.notif.addNotif("Not enough blood added to guarantee minimum supply")
            self.log.addLog("addBloodRecord", "Minimum supply not met after insertion", "failure")
    def ViewNotifs(self):
        return self.notif.viewNotifs()
    def ViewLog(self):
        return self.log.viewLog()
    def ViewBR(self):
        # transform BloodRecords into Strings
        return self.bloodBank.ViewAll() 
    def ViewBRLevels(self):
        return self.bloodBank.ViewBRLevels()
    def RequestBR(self, bloodType):
        #TODO implement the blood matching algorithm
        # checks if a responding to request will result in > minimum supply of blood
        if(self.bloodBank.BelowThreshold(-1)):
            self.notif.addNotif("Removal results in Blood Levels below minimum supply")
            self.log.addLog("bloodRequest", "Minimum supply not guaranteed after removal", "failure")
            return None
        if(self.bloodBank.CompatibleBloodExists(bloodType)):
            self.notif.addNotif("One unit of {} type blood has been used".format(bloodType.name))
            requestedBlood = self.bloodBank.GetBloodMatch(bloodType)
            self.log.addLog("bloodRequest", "Blood Record: {} used to respond to request".format(requestedBlood), "success")
            return requestedBlood
        # no blood found
        else:
            self.log.addLog("bloodRequest", "No available blood of type {}".format(bloodType.name), "failure")
            return None
