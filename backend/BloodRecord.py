from ShoddyDate import Date

class BloodRecord: 
    def __init__(self, bt, loc, dd1, mm1, yy1, dd2, mm2, yy2, ok):
        # Throw error on bad input
        self.bType = bt
        self.location = loc
        self.donationDate = Date(dd1,mm1,yy1) 
        self.expiryDate = Date(dd2,mm2,yy2) 
        self.isOkay = ok

    def hasExpired():
        current = Date(22,11,2019)
        tmp = (current < self.expiryDate)
        if(tmp):
            return false
        else: 
            return true

    def checkAndMark():
        expire = hasExpired()
        if(expire):
            self.isOkay = False
        
    # -1 for this blood record expires first
    # 1 for other blood record expires first
    # 0 for both blood records expire together
    def compareExpiration(b):
        t1 = self.expiryDate < b.expiryDate
        t2 = b.expiryDate < self.expiryDate

        if(t1):
            return -1
        elif(t2):
            return 1
        else:
            return 0


