class Notification():
    def __init__(self):
        self.notifs = []
    
    def addNotif(self, notif):
        self.notifs.append(notif)
        
    def viewNotifs(self):
        return self.notifs
