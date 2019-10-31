module BloodRep {
  import D = DateRep
  datatype BloodType = A | B | AB | O // A = 0, B = 1, AB = 2, O = 3
  datatype BloodRecord = BloodRecord(bType: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)

  predicate typeValid(req: BloodType, ret: BloodType)
  {
    match req
    case A => (ret == A || ret == O)
    case B => (ret == B || ret == O)
    case O => (ret == O)
    case AB => (ret == AB || ret == A || ret == B || ret == O)
  }
  
  method createBt(bType: int) returns(bt: BloodType)
  {
    if(bType == 0) {return A;}
    if(bType == 1) {return B;}
    if(bType == 2) {return AB;}
    if(bType == 3) {return O;}
  }
  
  method createBr(bt: BloodType, l: string, day1:int,month1:int,yr1:int, day2:int,month2:int,yr2:int, isOkay: bool) returns (br: BloodRecord)
  {
    var d1: D.Date, d2: D.Date;
    d1 := D.create(day1,month1,yr1);
    d2 := D.create(day2,month2,yr2);
    return BloodRecord(bt, l, d1, d2, isOkay);
  }

  method hasExpired(b1: BloodRecord) returns (b: bool)
  {
    var current := D.current();
    return D.LessThan(current, b1.expiryDate);
  }
}
