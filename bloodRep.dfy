include "dateRep.dfy"
module BloodRep {
  import D = DateRep

  // Enumeration
  // A = 0, B = 1, AB = 2, O = 3
  datatype BloodType = A | B | AB | O   
  
  method complete_enum(b: BloodType)
    ensures b == A || b == B || b == AB || b == O
  { }

  method createBt(bType: int) returns(bt: BloodType)
  {
    if(bType == 0) {return A;}
    if(bType == 1) {return B;}
    if(bType == 2) {return AB;}
    if(bType == 3) {return O;}
  }

  predicate typeValid(req: BloodType, ret: BloodType)
  {
    match req
    case A => (ret == A || ret == O)
    case B => (ret == B || ret == O)
    case O => (ret == O)
    case AB => (ret == AB || ret == A || ret == B || ret == O)
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


  class BloodRecord
  {
    var bType: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool;
    
    predicate Valid()
    reads this;
    { 
      D.validDate(donationDate.day, donationDate.month, donationDate.year) && D.validDate(expiryDate.day, expiryDate.month, expiryDate.year)
    }

    constructor(bt: BloodType, l: string, dd1: int,mm1:int,yy1:int, dd2:int,mm2:int,yy2:int, ok: bool)
      modifies this;
      requires D.validDate(dd1, mm1, yy1)
      requires D.validDate(dd2, mm2, yy2)
      ensures Valid();
      // Not sure if needed
      ensures bType == bt;
      ensures location == l;
      ensures donationDate.day == dd1;
      ensures donationDate.month== mm1;
      ensures donationDate.year == yy1;
      ensures expiryDate.day == dd2;
      ensures expiryDate.month== mm2;
      ensures expiryDate.year == yy2;
      ensures isOkay == ok;
    { 
      bType := bt; 
      location := l; 
      donationDate := D.create(dd1,mm1,yy1); 
      expiryDate := D.create(dd2,mm2,yy2); 
      isOkay := ok;
    }

    // Current date is set as 22 Nov 2019
    // Expiration as being the same day as expired date or later
    method hasExpired() returns (b: bool)
      ensures !b <==> pNotExpired() 
    {
      var d1 := expiryDate;
      var current := D.create(22, 11, 2019);
      // Tests whether it has not expired
      b := D.lessThan(current, expiryDate);
      // Get opposite 
      b := !b;
    }

    

    predicate pNotExpired()
      reads this
    {
      (2019 < expiryDate.year) 
          || (2019 == expiryDate.year && 11 < expiryDate.month) 
          || (2019 == expiryDate.year && 11 == expiryDate.month && 22 < expiryDate.day) 
    }
 
    method checkAndMark()
      modifies this
      ensures !pNotExpired() ==> !isOkay
    {
      var expire := hasExpired();
      if (expire) { 
        isOkay := false;
      }
    }

    predicate pExpireBefore(b1: BloodRecord, b2: BloodRecord) 
      requires b1 != null
      requires b2 != null
      reads b1
      reads b2
    {
      D.pLessThan(b1.expiryDate, b2.expiryDate)
    }

    method compare(b2: BloodRecord) returns (cmp: int)
      requires b2 != null
      ensures (cmp == -1) <==> pExpireBefore(this, b2)
      ensures (cmp == 0) <==> (!pExpireBefore(this, b2) && !pExpireBefore(b2,this))
      ensures (cmp == 1) <==> pExpireBefore(b2, this)
    {
      var a := D.lessThan(expiryDate, b2.expiryDate);
      var b := D.lessThan(b2.expiryDate, expiryDate);

      assert( a ==> !b && b ==> !a);

      if (a) { return -1; } 
      else if (b) { return 1; }
      else { return 0; }

    }

  }

  predicate typeMatch(t1:BloodRecord, t2:BloodType)
  {
    match t1.bType
    case A => t2 == A
    case B => t2 == B
    case O => t2 == O
    case AB => t2 == AB 
  }

  method Test() 
  {
    var typeA := createBt(0);
    var typeB := createBt(1);
    var typeAB := createBt(2);
    var typeO := createBt(3);
    
    var br1 := new BloodRecord(typeA, "Backyard", 4, 2, 2003, 12, 4, 2007, true);
    var br2 := new BloodRecord(typeA, "Backyard", 1, 2, 2013, 11, 5, 2015, true);

    var test1 := br1.hasExpired();
    var test2 := br1.compare(br1);
    var test3 := br1.compare(br2);
    var test4 := br2.compare(br1);

    assert(test1);    
    assert(test2 == 0); 
    assert(test4 == 1);
    assert(test3 == -1);
  }

}

