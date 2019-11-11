include "dateRep.dfy"
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
  
  // Create a blood record
  // TODO make a date addition to automatically set expiry date rather than pass through
  method createBr(bt: BloodType, l: string, dd1:int,mm1:int,yy1:int, dd2:int,mm2:int,yy2:int, isOkay: bool) returns (br: BloodRecord)
  requires D.validDate(dd1, mm1, yy1)
  requires D.validDate(dd2, mm2, yy2)
  ensures br.bType == bt
  ensures br.location == l
  ensures br.donationDate.day == dd1
  ensures br.donationDate.month== mm1
  ensures br.donationDate.year == yy1
  ensures br.expiryDate.day == dd2
  ensures br.expiryDate.month== mm2
  ensures br.expiryDate.year == yy2
  ensures br.isOkay == isOkay
  {
    var d1 := D.create(dd1,mm1,yy1);
    var d2 := D.create(dd2,mm2,yy2);
    br := BloodRecord(bt, l, d1, d2, isOkay);
  }
 
  // Current date is set as 22 Nov 2019
  method hasExpired(b1: BloodRecord) returns (b: bool)
  ensures !b <==> (2019 < b1.expiryDate.year) 
              || (2019 == b1.expiryDate.year && 11 < b1.expiryDate.month) 
              || (2019 == b1.expiryDate.year && 11 == b1.expiryDate.month && 22 < b1.expiryDate.day) 
  {
    var d1 := b1.expiryDate;
    var current := D.create(22, 11, 2019);
    // Tests whether it has not expired
    b := D.lessThan(current, b1.expiryDate);
    // Get opposite 
    b := !b;
  }

  method compare(b1: BloodRecord, b2: BloodRecord) returns (cmp: int)
  ensures (cmp == -1) <==> (b1.expiryDate.year < b2.expiryDate.year) 
                       || (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month < b2.expiryDate.month) 
                       || (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month == b2.expiryDate.month && b1.expiryDate.day < b2.expiryDate.day)  
  ensures (cmp == 0) <==> (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month == b2.expiryDate.month && b1.expiryDate.day == b2.expiryDate.day)

  ensures (cmp == 1) <==> (b2.expiryDate.year < b1.expiryDate.year) 
                       || (b2.expiryDate.year == b1.expiryDate.year && b2.expiryDate.month < b1.expiryDate.month) 
                       || (b2.expiryDate.year == b1.expiryDate.year && b2.expiryDate.month == b1.expiryDate.month && b2.expiryDate.day < b1.expiryDate.day)
  {
    var a := D.lessThan(b1.expiryDate, b2.expiryDate);
    var b := D.lessThan(b2.expiryDate, b1.expiryDate);
    assert( a ==> !b && b ==> !a);
    if (a) { return -1; } 
    else if (b) { return 1; }
    else { return 0; }
  }
  
  method Test() 
  {
    var typeA := createBt(0);
    var typeB := createBt(1);
    var typeAB := createBt(2);
    var typeO := createBt(3);
    
    var br1 := createBr(typeA, "Backyard", 4, 2, 2003, 12, 4, 2007, true);
    var br2 := createBr(typeA, "Backyard", 1, 2, 2013, 11, 5, 2015, true);

    var test1 := hasExpired(br1);
    var test2 := compare(br1, br1);
    var test3 := compare(br1, br2);
    var test4 := compare(br2, br1);

    assert(test1);    
    assert(test2 == 0); 
    assert(test4 == 1);
    assert(test3 == -1);
  }
    
  method getBTasString(bt: BloodType) returns(s: string)
  {
    match bt
    case A => return "A";
    case B => return "B";
    case AB => return "AB";
    case O => return "O";
  }

  method getBTasInt(bt: BloodType) returns(i: int)
  {
    match bt
    case A => return 1;
    case B => return 2;
    case AB => return 3;
    case O => return 4;
  }

}
