from datetime import datetime
class Notification():
    def __init__(self):
        self.notifs = []
    
    def addNotif(self, notif):
        self.notifs.append((datetime.now().ctime(),notif))
        
    def viewNotifs(self):
        n = self.notifs
        self.notifs = []
        return n
