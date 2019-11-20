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
        if(isOkay == "True"):
            br = BloodRecord(bloodType,Location,day1,month1,year1,day2,month2,year2,isOkay)
            if(br.hasExpired()):
                self.log.addLog("addBloodRecord", "BloodRecord: {}, {}-{}-{}, {}-{}-{}, {} expired".format(bloodType.name, year1, month1, day1, year2, month2, day2, Location), "failure")
                self.notif.addNotif("Expired blood can not be entered into the system")
                if(self.bloodBank.BelowThreshold(0)):
                    self.notif.addNotif("Not enough blood added to guarantee minimum supply")
                    self.log.addLog("addBloodRecord", "Minimum supply not met after insertion", "success")
            else:
                self.bloodBank.Push(bloodType, br)
                self.log.addLog("addBloodRecord", "Added BloodRecord: {}, {}-{}-{}, {}-{}-{}, {}".format(bloodType.name, year1, month1, day1, year2, month2, day2, Location), "success")
                if(self.bloodBank.BelowThreshold(1)):
                    self.notif.addNotif("Not enough blood added to guarantee minimum supply")
                    self.log.addLog("addBloodRecord", "Minimum supply not met after insertion", "success")
        else:
            self.log.addLog("addBloodRecord", "BloodRecord: {}, {}-{}-{}, {}-{}-{}, {} rejected".format(bloodType.name, year1, month1, day1, year2, month2, day2, Location), "failure")
            if(self.bloodBank.BelowThreshold(0)):
                self.notif.addNotif("Not enough blood added to guarantee minimum supply")
                self.log.addLog("addBloodRecord", "Minimum supply not met after insertion", "success")
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
        while(self.bloodBank.CompatibleBloodExists(bloodType)):
            # checks if a responding to request will result in > minimum supply of blood
            if(self.bloodBank.BelowThreshold(-1)):
                self.notif.addNotif("Removal results in blood levels below minimum supply")
                self.log.addLog("bloodRequest", "Minimum supply not guaranteed after removal", "failure")
                return None
            else:
                requestedBlood = self.bloodBank.GetBloodMatch(bloodType)
                # found expired blood so we dont return it
                # Qop has already removed it from the system
                # continue looping to find suitable blood for request
                if(requestedBlood.hasExpired()):
                    self.notif.addNotif("Expired blood has been found and removed")
                    self.log.addLog("expiredBlood", "expired BloodRecord: {}, {}-{}-{}, {}-{}-{}, {} found and removed".format(requestedBlood.bType.name, requestedBlood.donationDate.year, requestedBlood.donationDate.month, requestedBlood.donationDate.day, requestedBlood.expiryDate.year, requestedBlood.expiryDate.month, requestedBlood.expiryDate.day, requestedBlood.location), "success")
                    continue
                else:
                    self.notif.addNotif("One unit of {} type blood has been used".format(bloodType.name))
                    self.log.addLog("bloodRequest", "BloodRecord: {}, {}-{}-{}, {}-{}-{}, {} used to respond to request".format(requestedBlood.bType.name, requestedBlood.donationDate.year, requestedBlood.donationDate.month, requestedBlood.donationDate.day, requestedBlood.expiryDate.year, requestedBlood.expiryDate.month, requestedBlood.expiryDate.day, requestedBlood.location), "success")
                    return self.bloodBank.BRToJSONString(requestedBlood)
        # no blood found
        else:
            self.log.addLog("bloodRequest", "No available blood of type {}".format(bloodType.name), "failure")
            return None
