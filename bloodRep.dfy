module BloodRep {
  import D = DateRep
  datatype BloodType = A | B | AB | O // A = 0, B = 1, AB = 2, O = 3
  datatype BloodRecord = BloodRecord(bType: BloodType, location: int, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)

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
  //requires validDate(dd, mm, yy)
  requires 0 < dd1 <= 31
  requires 0 < mm1 <= 12
  requires 0 < yy1 <= 2019
  requires 0 < dd2 <= 31
  requires 0 < mm2 <= 12
  requires 0 < yy2 <= 2019
  {
    var d1: D.Date, d2: D.Date;
    assert (0 < dd1 <= 31);
    assert (0 < mm1 <= 12);
    assert (0 < yy1 <= 2019);

    assert (0 < dd2 <= 31);
    assert (0 < mm2 <= 12);
    assert (0 < yy2 <= 2019);

    d1 := D.create(dd1,mm1,yy1);
    d2 := D.create(dd2,mm2,yy2);
    return BloodRecord(bt, l, d1, d2, isOkay);
  }


  method hasExpired(b1: BloodRecord) returns (b: bool)
  ensures b <==> D.current.
  ensures b <==> (D.current.year < b1.expiryDate.year) 
                       || (D.current.year == b1.expiryDate.year && D.current.month < b1.expiryDate.month) 
                       || (D.current.year == b1.expiryDate.year && D.current.month == b1.expiryDate.month && D.current.day < b1.expiryDate.day)  
  {
    b := D.lessThan(D.current, b1.expiryDate);
    b := !b;
    // This is stupid 
    // Pls fix if you know how to do it :c
  }

  method compare(b1: BloodRecord, b2: BloodRecord) returns (cmp: int)
  ensures (cmp == -1) ==> (b1.expiryDate.year < b2.expiryDate.year) 
                       || (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month < b2.expiryDate.month) 
                       || (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month == b2.expiryDate.month && b1.expiryDate.day < b2.expiryDate.day)  
  ensures (cmp == 0) ==> (b1.expiryDate.year == b2.expiryDate.year && b1.expiryDate.month == b2.expiryDate.month && b1.expiryDate.day == b2.expiryDate.day)

  ensures (cmp == 1) ==> (b2.expiryDate.year < b1.expiryDate.year) 
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
    var br3 := createBr(typeA, "Backyard", 17, 5, 2014, 1, 7, 2016, true);

    var test1 := hasExpired(br1);
    var test2 := compare(br1, br1);
    var test3 := compare(br1, br2);
    var test4 := compare(br2, br1);

    assert(test1);
    
    assert(test2 == 0); 
    assert(test3 == -1);
    assert(test4 == 1);
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

  method getBloodType(br: BloodRecord) returns(bt: BloodType)
  {
    return br.bType;
  }

  method getLocation(br: BloodRecord) returns(location: int) 
  {
    return br.location;
  }

  method getProductionDate(br: BloodRecord) returns(proDate: D.Date)
  {
    return br.donationDate;
  }

  method getExpiryDate(br: BloodRecord) returns(expDate: D.Date)
  {
    return br.expiryDate;
  }

  method hasExpired(br: BloodRecord) returns (b: bool)
  {
    var current := D.current();
    b := D.LessThan(current, br.expiryDate);
  }
  
}

