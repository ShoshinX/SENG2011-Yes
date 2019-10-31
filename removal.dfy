method Remove(bl: BloodRecord, l: Log) 
// ensures blood is removed from available blood 
{

}

method CheckForRemoval(db: array<BloodRecord>) 
ensures forall i :: 0 <= i < db.Length ==> !hasExpired(b[i]) 
modifies db
{
  var i := 0;
  while (i<db.Length)
  ensures 0 <= i <= db.Length
  ensures forall m :: 0 <= m < i ==> !hasExpired(db[m]) 
  {
    if(hasExpired(db[i])){ Remove(db[i], /*LOG*/ )}
  }
}
