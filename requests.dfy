import B = BloodRep

// Assume inventory blood is sorted by expiry date
// Gets an instance of the blood by the type
method searchByType(bt: B.BloodType, inventory: array<B.BloodRecord>) returns (result: B.BloodRecord) 
modifies inventory
requires inventory != null
requires !forall elm :: 0 <= elm < inventory.Length ==> inventory[elm].bType != bt
ensures result.bType == bt
// Requires assumption for sorted inventory
//ensures forall m :: 0 <= m < inventory.Length && inventory[m].bType == bt ==> !B.pExpireBefore(inventory[m], result)
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

method Test() 
{
  var typeA := B.createBt(0);
  var typeB := B.createBt(1);
  var typeAB := B.createBt(2);
  var typeO := B.createBt(3);
    
  var br1 := B.createBr(typeA, "Backyard", 4, 2, 2003, 12, 4, 2007, true);
  var br2 := B.createBr(typeB, "Backyard", 1, 2, 2013, 11, 5, 2015, true);
  var br3 := B.createBr(typeAB, "Shady Alley", 14, 5, 2017, 16, 8, 2017, true);
  
  var inv := new B.BloodRecord[3];
  inv[0], inv[1], inv[2] := br1, br2, br3;
  assert(inv[0].location == "Backyard");
  assert(inv[1].location == "Backyard");
  assert(inv[2].location == "Shady Alley");
  var res := searchByType(typeA, inv);
  assert(res.location == "Backyard");

  
}
