from Quack import Quack
from BloodType import BloodType
import sys
from BloodRecord import BloodRecord

class BloodBank():

    def __init__(self):
        self.A = Quack(1)
        self.B = Quack(1)
        self.AB = Quack(1)
        self.O = Quack(1)

    def BRToJSONString(self,bloodRecord):
        return {"BloodType": bloodRecord.bType.name, "location": bloodRecord.location, "donationDate": bloodRecord.donationDate.toString(), "expiryDate": bloodRecord.expiryDate.toString(), "isOkay": bloodRecord.isOkay}
    
    def ViewAll(self):
        return [self.BRToJSONString(x) for x in self.A.buf[self.A.m:self.A.n] + self.B.buf[self.B.m:self.B.n] + self.AB.buf[self.AB.m:self.AB.n] + self.O.buf[self.O.m:self.O.n]]
    
    def ViewBRLevels(self):
        return [self.A.Length(),self.B.Length(),self.AB.Length(),self.O.Length()]
        
    def BelowThreshold(self, n):
        return self.A.Length() + self.B.Length() + self.AB.Length() + self.O.Length() + n <= 4

    def Empty(self, bloodType):
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    return self.A.Empty()
                elif bloodType == BloodType.B:
                    return self.B.Empty()
                elif bloodType == BloodType.AB:
                    return self.AB.Empty()
                elif bloodType == BloodType.O:
                    return self.O.Empty()
        except Exception as inst:
            print("Blood Type doesn't Exist in Empty", file=sys.stderr)

    def Pop(self, bloodType):
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    return self.A.Pop()
                elif bloodType == BloodType.B:
                    return self.B.Pop()
                elif bloodType == BloodType.AB:
                    return self.AB.Pop()
                elif bloodType == BloodType.O:
                    return self.O.Pop()
        except Exception as inst:
            print("Blood Type doesn't Exist in Pop", file=sys.stderr)
    def Qop(self, bloodType):
        #TODO handle removal of bad blood and expired blood
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    r = self.A.Qop()
                elif bloodType == BloodType.B:
                    r = self.B.Qop()
                elif bloodType == BloodType.AB:
                    r = self.AB.Qop()
                elif bloodType == BloodType.O:
                    r = self.O.Qop()
                return r
        except Exception as inst:
            print("Blood Type doesn't Exist in Qop", file=sys.stderr)
    def Push(self, bloodType, bloodRecord):
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    self.A.Push(bloodRecord)
                elif bloodType == BloodType.B:
                    self.B.Push(bloodRecord)
                elif bloodType == BloodType.AB:
                    self.AB.Push(bloodRecord)
                elif bloodType == BloodType.O:
                    self.O.Push(bloodRecord)
        except Exception as inst:
            print("Blood Type doesn't Exist in Push", file=sys.stderr)
    def HeadTail(self,bloodType):
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    self.A.HeadTail()
                elif bloodType == BloodType.B:
                    self.B.HeadTail()
                elif bloodType == BloodType.AB:
                    self.AB.HeadTail()
                elif bloodType == BloodType.O:
                    self.O.HeadTail()
        except Exception as inst:
            print("Blood Type doesn't Exist in HeadTail", file=sys.stderr)
            
    def GetBloodMatch(self, bType): 
        try: 
            if not self.CompatibleBloodExists(bType):
                raise Exception()
            else:
                target = self.CompatibleBlood(bType)
                if target == BloodType.A:
                    return self.Qop(target)
                elif target == BloodType.B:
                    return self.Qop(target)
                elif target == BloodType.AB:
                    return self.Qop(target)
                elif target == BloodType.O:
                    return self.Qop(target)
        except Exception as inst: #Not sure why 
            print("No compatible blood existed", file=sys.stderr)

    def CompatibleBloodExists(self, bType):
        if(bType == BloodType.A):
            existsA = not self.Empty(BloodType.A)
            existsO = not self.Empty(BloodType.O)
            return (existsA or existsO)
        elif(bType == BloodType.B):
            existsB = not self.Empty(BloodType.B)
            existsO = not self.Empty(BloodType.O)
            return (existsB or existsO)
        elif(bType == BloodType.AB):
            existsAB = not self.Empty(BloodType.AB)
            existsA = not self.Empty(BloodType.A)
            existsB = not self.Empty(BloodType.B)
            existsO = not self.Empty(BloodType.O)
            return (existsA or existsB or existsAB or existsO)
        elif(bType == BloodType.O):
            existsO = not self.Empty(BloodType.O)
            return existsO
        else:
            return false

    # Unverified
    def CompatibleBlood(self, bType):
        if(bType == BloodType.A):
            if(not self.Empty(BloodType.A)): 
                return BloodType.A
            if(not self.Empty(BloodType.O)):
                return BloodType.O
        elif(bType == BloodType.B):
            if(not self.Empty(BloodType.B)):
                return BloodType.B
            if(not self.Empty(BloodType.O)):
                return BloodType.O
        elif(bType == BloodType.AB):
            if(not self.Empty(BloodType.AB)):
                return BloodType.AB
            if(not self.Empty(BloodType.A)):
                return BloodType.A
            if(not self.Empty(BloodType.B)):
                return BloodType.B
            if(not self.Empty(BloodType.O)):
                return BloodType.O
        elif(bType == BloodType.O):
            if(not self.Empty(BloodType.O)):
                return BloodType.O



