// Should only be interacted by bloodRep
// If something doesn't exist there then make it here  and wrap it in blood

module DateRep 
{
  // Start a 0 bc Dafny checks for 0, ask about witnesses
  //newtype Month = x : int | 0 <= x < 12
  //newtype Year = x : int | 0 <= x < 2019
  //newtype Day = x : int | 0 <= x < 31 
  
  method create(dd: int, mm: int, yyyy: int) returns(date: Date)
  {
    if(dd > 31 || mm > 12 || yyyy > 2020) {return Date(0, 0, 0);}
    date := Date(dd, mm, yyyy);
  }
  
  datatype Date = Date(day: int, month: int, year: int)

  // Get current date
  method current() returns (d: Date)
  {
    d := Date(0,0,0);
    // idk how to implement 
  }

  // d1 is before d2
  method LessThan(d1:Date, d2:Date) returns (b: bool)
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
  
}

