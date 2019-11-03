import B = BloodRep
datatype BloodType = A | B | AB | O // A = 0, B = 1, AB = 2, O = 3
datatype BloodRecord = BloodRecord(bType: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)

method matchingBlood(patientBloodType: BloodType, a:array<BloodRecord>) returns (compatibleBlood: bool)
    ensures patientBloodType == O && !doesExist(O, a) ==> compatibleBlood == false
    ensures patientBloodType == O && doesExist(O, a) ==> compatibleBlood == true
    ensures patientBloodType == A && doesExist(A, a) ==> compatibleBlood == true
    ensures patientBloodType == A && !doesExist(A, a) && doesExist(O, a) ==> compatibleBlood == true
    ensures patientBloodType == A && !doesExist(A, a) && !doesExist(O, a) ==> compatibleBlood == false
    ensures patientBloodType == B && doesExist(B, a) ==> compatibleBlood == true
    ensures patientBloodType == B && !doesExist(B, a) && doesExist(O, a) ==> compatibleBlood == true
    ensures patientBloodType == B && !doesExist(B, a) && !doesExist(O, a) ==> compatibleBlood == false
    ensures patientBloodType == AB && doesExist(AB, a) ==> compatibleBlood == true
    ensures patientBloodType == AB && !doesExist(AB, a) && 
        doesExist(A, a) ==> compatibleBlood == true
    ensures patientBloodType == AB && !doesExist(AB, a) && 
        !doesExist(A, a) && doesExist(B, a) ==> compatibleBlood == true
    ensures patientBloodType == AB && !doesExist(AB, a) && 
        !doesExist(A, a) && !doesExist(B, a) && doesExist(O, a) ==> compatibleBlood == true
    ensures patientBloodType == AB && !doesExist(AB) && 
        !doesExist(A, a) && !doesExist(B, a) && !doesExist(O, a) ==> compatibleBlood == false
{
    if (patientBloodType == O && !doesExist(O, a))
    {
            compatibleBlood := false;
    }
    if (patientBloodType == O && doesExist(O, a))
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && doesExist(A, a))
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && !doesExist(A, a) && doesExist(O, a))
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && !doesExist(A, a) && !doesExist(O, a))
    {
        compatibleBlood := false;
    }
    if (patientBloodType == B && doesExist(B, a))
    {
        compatibleBlood := true;
    }
    if (patientBloodType == B && !doesExist(B, a) && doesExist(O, a))
    {
        compatibleBlood := true;
    }
    if (patientBloodType == B && !doesExist(B, a) && !doesExist(O, a))
    {
        compatibleBlood := false;
    }
    if (patientBloodType == AB && doesExist(AB, a))
    {
        compatibleBlood := true;
    }
}

method doesExist(a:array<BloodRecord>, bType: BloodType) returns (Exists: bool)
    requires a != null && a.Length > 0
    ensures Exists == exists k :: 0 <= k < a.Length && a[k].bType == bType
{
    var i := 0;
    Exists := false;
    while (i < a.Length)
        decreases a.Length - i
        invariant 0 <= i <= a.Length
        invariant Exists == true ==> exists k :: 0 <= k <= i && a[k].bType == bType 
    {
        if (a[i].bType == bType)
        {
            Exists := true;
        }
    }
}