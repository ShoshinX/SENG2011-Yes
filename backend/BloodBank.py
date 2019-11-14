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
    
    def ViewAll(self):
        def BRToJSONString(bloodRecord):
            return {"BloodType": bloodRecord.bType.name, "location": bloodRecord.location, "donationDate": bloodRecord.donationDate.toString(), "expiryDate": bloodRecord.expiryDate.toString(), "isOkay": bloodRecord.isOkay}
        return [BRToJSONString(x) for x in self.A.buf[self.A.m:self.A.n] + self.B.buf[self.B.m:self.B.n] + self.AB.buf[self.AB.m:self.AB.n] + self.O.buf[self.O.m:self.O.n]]
    
    def ViewBRLevels(self):
        return [self.A.Length(),self.B.Length(),self.AB.Length(),self.O.Length()]

    def Empty(self, bloodType):
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    self.A.Empty()
                elif bloodType == BloodType.B:
                    self.B.Empty()
                elif bloodType == BloodType.AB:
                    self.AB.Empty()
                elif bloodType == BloodType.O:
                    self.O.Empty()
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
        try:
            if bloodType not in BloodType:
                raise Exception()
            else:
                if bloodType == BloodType.A:
                    return self.A.Qop()
                elif bloodType == BloodType.B:
                    return self.B.Qop()
                elif bloodType == BloodType.AB:
                    return self.AB.Qop()
                elif bloodType == BloodType.O:
                    return self.O.Qop()
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