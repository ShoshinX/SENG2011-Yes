datatype BloodRecord = BloodRecord(blood: char, location: string, donationDate: Date, expiryDate: Date)

datatype Date = (day: Day, month: Month, year: Year);

newtype Month = x : int | 0 < x <= 12
newtype Year = x : int | 0 < x <= 2019
newtype Day = x : int | 0 < x <= 31 

// Valid date

method ReachedDate(s:Date, e:Date) returns (b : bool)
ensures b <==> s.year < e.year || (s.year == e.year && s.month < e.month) || (s.year == e.year && s.month == e.month && s.day < e.day) 
{

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

method Remove(bl: BloodRecord, l: Log) 
// ensures blood is removed from available blood 
{

}

method CheckForRemoval(db: array<BloodRecord>) 
ensures forall i :: 0 <= i < db.Length ==> !ReachedDate(db[i].donationDate, db[i].expiryDate) 
modifies db
{
  var i := 0;
  while (i<db.Length)
  ensures 0 <= i <= db.Length
  ensures forall m :: 0 <= m < i ==> !ReachedDate(db[m].donationDate, db[m].expiryDate) 
  {
    if(ReachedDate(db[i].donationDate, db[i].expiryDate)){ Remove(db[i], /*LOG*/ )}
  }
}
