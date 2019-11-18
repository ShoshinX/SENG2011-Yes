from Log import Log
from datetime import datetime
class Logs():
    #TODO
    def __init__(self):
        self.log = []

    def addLog(self, action, message, status):
        self.log.append(Log(action,message, datetime.now().ctime(), status)) 
        
    def viewLog(self):
        return [Log.vl(l) for l in self.log]
