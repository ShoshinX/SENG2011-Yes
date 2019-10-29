import B = BloodRep

method Matching(request: B.BloodType, inventory: array<B.BloodRecord>) returns (br: B.BloodRecord)
{ 
  
}

method Retrieve(br: B.BloodRecord, inventory: array<B.BloodRecord>) returns (success: bool) 
modifies inventory
{

}

method Request(request: B.BloodType, inventory: array<B.BloodRecord>) returns (success: bool)
{

}
