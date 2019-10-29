module DateRep 
{

  newtype Month = x : int | 0 < x <= 12
  newtype Year = x : int | 0 < x <= 2019
  newtype Day = x : int | 0 < x <= 31 
  
  datatype Date = (day: Day, month: Month, year: Year);

  method LessThan(d1:Date, d2:Date) returns (b: bool)
  ensures b <==> s.year < e.year || (s.year == e.year && s.month < e.month) || (s.year == e.year && s.month == e.month && s.day < e.day) 
  {
    
  }

  if (e.day > s.day) {
    b := false;
  } else {
    b := true;
  }
  if (e.month > s.month) {
    b := false;
  }
  if(e.year > s.year) {
    b := false;
  } 
}
}
