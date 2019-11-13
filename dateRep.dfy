// Should only be interacted by bloodRep
// If something doesn't exist there then make it here  and wrap it in blood

module DateRep 
{
  // Start a 0 bc Dafny checks for 0, ask about witnesses
  newtype Month = x : int | 0 <= x < 12 
  newtype Year = x : int | 0 <= x  
  newtype Day = x : int | 0 <= x < 31 

  predicate validDate(dd: int, mm: int, yyyy: int)
  {
    (0 <= mm < 12) && (0 <= yyyy ) && (0 <= dd < 31)
  }

  method isValid(dd: int, mm: int, yyyy: int) returns (b:bool)
    ensures b <==> validDate(dd, mm, yyyy)
  {
    b := ( (0 <= mm < 12) && (0 <= yyyy) && (0 <= dd < 31));
  }

  method create(dd: int, mm: int, yyyy: int) returns(date: Date)
    requires validDate(dd, mm, yyyy)
    requires 0 <= dd < 31
    requires 0 <= mm < 12
    requires 0 <= yyyy 
    ensures date.day == dd
    ensures date.month == mm
    ensures date.year == yyyy
  {
    assert validDate(dd, mm, yyyy);
    var d := Day(dd) ;
    var m := Month(mm);
    var y := Year(yyyy);
    date := Date(dd, mm, yyyy);
  }
  
  datatype Date = Date(day: int, month: int, year: int)

  predicate pLessThan(d1: Date, d2: Date) {
    (d1.year < d2.year) 
              || (d1.year == d2.year && d1.month < d2.month) 
              || (d1.year == d2.year && d1.month == d2.month && d1.day < d2.day) 
  }
  
  // d1 is before d2
  method lessThan(d1:Date, d2:Date) returns (b: bool)
    ensures b <==> pLessThan(d1, d2)
  {
    // Compare days
    b := d2.day > d1.day;
    // Compare months, overrides days if larger or uses days to resolve tie
    b := (d2.month > d1.month) || (b && d2.month == d1.month); 
    // Compare years, overrides months if larger or uses previous to resolve tie
    b := (d2.year > d1.year) || (b && d2.year == d1.year);
  }

  // For testing module
  method Test()
  {
    var a := Date(1,12, 2014);
    var b := Date(21, 1, 2015);

    var test1 := lessThan(a, b);
    var test2 := lessThan(b, a);
    var test3 := lessThan(b, b);

    assert (test1);
    assert (!test2);    
    assert (!test3);

    var sameYear1 := Date(21, 2, 2015);
    var sameYear2 := Date(11, 1, 2015);
  
    var testYear := lessThan(sameYear2, sameYear1);
    assert(testYear);    

    var sameYearMonth1 := Date(21, 2, 2015);
    var sameYearMonth2 := Date(1, 2, 2015);

    var testYearMonth := lessThan(sameYearMonth2, sameYearMonth1);
    assert(testYearMonth);

  }
  
}

