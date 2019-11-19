from ShoddyDate import SDate

class BloodRecord: 
    def __init__(self, bt, loc, dd1, mm1, yy1, dd2, mm2, yy2, ok):
        # Throw error on bad input
        self.bType = bt
        self.location = loc
        self.donationDate = SDate(dd1,mm1,yy1) 
        self.expiryDate = SDate(dd2,mm2,yy2) 
        self.isOkay = ok

    def hasExpired(self):
        current = SDate(22,11,2019)
        tmp = (current < self.expiryDate)
        if(tmp):
            return False
        else: 
            return True

    def checkAndMark(self):
        expire = self.hasExpired()
        if(expire):
            self.isOkay = False
        
    # -1 for this blood record expires first
    # 1 for other blood record expires first
    # 0 for both blood records expire together

    # compareExpiration name method
    def __le__(self,b):
        #t1 = 
        return self.expiryDate <= b.expiryDate
        #t2 = b.expiryDate < self.expiryDate

        #if(t1):
        #    return -1
        #elif(t2):
        #    return 1
        #else:
        #    return 0


