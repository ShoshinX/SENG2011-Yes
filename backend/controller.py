from BloodBank import BloodBank
from Notification import Notification
from Log import Log

class Controller():
    def __init__(self):
        self.notif = Notification()
        self.log = Log()
        self.bloodBank = BloodBank()
    
    #TODO
    #def addBR():
    #def ViewNotif():
    #def ViewLog():
    #def ViewBR():
    #def ViewBRLevels():