import B = BloodRep

// Assume inventory blood is sorted by expiry date
// Gets an instance of the blood by the type
method searchByType(bt: B.BloodType, inventory: array<B.BloodRecord>) returns (result: B.BloodRecord) 
modifies inventory
requires inventory != null
requires !forall elm :: 0 <= elm < inventory.Length ==> inventory[elm].bType != bt
requires exists elm :: 0 <= elm < inventory.Length && inventory[elm].bType == bt
{
  var i := 0;
  while (i<inventory.Length) 
  invariant 0 <= i <= inventory.Length
  // Everything before the point being searched does not contain the correct type
  invariant forall m :: 0 <= m < i ==> !sameType(inventory[m].bType, bt) 
  {
    if(inventory[i].bType == bt) {
      result := inventory[i];
      break;
    }
    assert (inventory[i].bType != bt);
    i := i + 1; 
  }
}

function sameType(t1: B.BloodType, t2: B.BloodType): bool
{
  t1 == t2
}
