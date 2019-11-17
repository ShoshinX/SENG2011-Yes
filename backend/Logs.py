from Log import Log
from datetime import datetime
class Logs():
    #TODO
    def __init__(self):
        self.log = []

    def addLog(self, action, message):
        self.log.append(Log(action,message, datetime.now().ctime())) 