// Should only be interacted by bloodRep
// If something doesn't exist there then make it here  and wrap it in blood

module DateRep 
{
  // Start a 0 bc Dafny checks for 0, ask about witnesses
  newtype Month = x : int | 0 < x <= 12 witness 1
  newtype Year = x : int | 0 < x <= 2019 witness 1
  newtype Day = x : int | 0 < x <= 31 witness 1

  predicate validDate(dd: int, mm: int, yyyy: int)
  {
    (0 < mm <= 12) && (0 < yyyy <= 2019) && (0 < dd <= 31)
  }

  method isValid(dd: int, mm: int, yyyy: int) returns (b:bool)
  ensures b <==> validDate(dd, mm, yyyy)
  {
    b := ( (0 < mm <= 12) && (0 < yyyy <= 2019) && (0 < dd <= 31));
  }

  method create(dd: int, mm: int, yyyy: int) returns(date: Date)
  requires validDate(dd, mm, yyyy)
  requires 0 < dd <= 31
  requires 0 < mm <= 12
  requires 0 < yyyy <= 2019
  ensures date.day == dd as Day
  ensures date.month == mm as Month
  ensures date.year == yyyy as Year
  {
    assert validDate(dd, mm, yyyy);
    var d := dd as Day;
    var m := mm as Month;
    var y := yyyy as Year;
    date := Date(d, m, y);
    // if(dd > 31 || mm > 12 || yyyy > 2020) {return Date(0, 0, 0);}
    // date := Date(dd, mm, yyyy);
  }
  
  datatype Date = Date(day: int, month: int, year: int)

  // Get current date
  // idk how to implement 
  //static var current := create(1,10,2019); 
  method current() returns (d: Date)
  ensures d.day == 1 as Day
  ensures d.month == 10 as Month
  ensures d.year == 2019 as Year
  {
    var day := 1;
    var m := 10;
    var y := 2019;
    /*
    assert (0 < day <= 31);
    assert (0 < m <= 12);
    assert (0 < y <= 2019);
    */
    assert validDate(day,m,y);
  
    assert(day == 1);
    assert(m == 10);
    assert(y == 2019);
    d := create(day,m,y); 
    assert(d.day == 1 as Day);
    assert(d.month == 10);
    assert(d.year == 2019);
  }
  


  
  // d1 is before d2
  method lessThan(d1:Date, d2:Date) returns (b: bool)
  ensures b <==> (d1.year < d2.year) 
              || (d1.year == d2.year && d1.month < d2.month) 
              || (d1.year == d2.year && d1.month == d2.month && d1.day < d2.day) 
  {
    // Compare days
    b := d2.day > d1.day;
    // Compare months, overrides days if larger or uses days to resolve tie
    b := (d2.month > d1.month) || (b && d2.month == d1.month); 
    // Compare years, overrides months if larger or uses previous to resolve tie
    b := (d2.year > d1.year) || (b && d2.year == d1.year);     
  }

  // For testing module
  /*
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
  }
  */
}

