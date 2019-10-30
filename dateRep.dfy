module DateRep 
{
  // Start a 0 bc Dafny checks for 0, ask about witnesses
  newtype Month = x : int | 0 <= x < 12
  newtype Year = x : int | 0 <= x < 2019
  newtype Day = x : int | 0 <= x < 31 
    
  datatype Date = Date(day: Day, month: Month, year: Year)

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

