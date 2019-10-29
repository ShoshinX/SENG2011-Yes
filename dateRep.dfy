module DateRep 
{

  newtype Month = x : int | 0 < x <= 12
  newtype Year = x : int | 0 < x <= 2019
  newtype Day = x : int | 0 < x <= 31 
  
  datatype Date = (day: Day, month: Month, year: Year);

  // d1 is before d2
  method LessThan(d1:Date, d2:Date) returns (b: bool)
  ensures b <==> d1.year < d2.year || (d1.year == d2.year && d1.month < d2.month) || (d1.year == d2.year && d1.month == d2.month && d1.day < d2.day) 
  {
    if (d2.day > d1.day) {
      b := true;
    } else {
      b := false;
    }
    if (d2.month > d1.month) {
      b := true;
    } else {
      b := b && (d2.month == d1.month)
    }
    if(d2.year > d1.year) {
      b := true;
    } else {
      b := b && (d2.year == d2.year)
    }
    
  }
}
