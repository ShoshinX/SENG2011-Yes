class Log():
    def __init__(self, action, message, time, status):
        self.action = action
        self.message = message
        self.time = time
        self.status = status
        
    def vl(self):
        return {"Action": self.action, "Message": self.message, "DateTime": self.time, "Status": self.status}
