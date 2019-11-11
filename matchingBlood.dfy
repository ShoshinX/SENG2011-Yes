include "bloodRep.dfy"
include "dateRep.dfy"
import B = BloodRep
  import D = DateRep
datatype BloodType = A | B | AB | O // A = 0, B = 1, AB = 2, O = 3
datatype BloodRecord = BloodRecord(bType: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)

method matchingBlood(patientBloodType: BloodType, a:array<BloodRecord>) returns (compatibleBlood: bool)
    requires a != null && a.Length > 0
    ensures compatibleBlood == compatibleBloodExists(patientBloodType, a)
{
    var validO := doesExist(O, a);
    var validA := doesExist(A, a);
    var validAB := doesExist(AB, a);
    var validB := doesExist(B, a);
    if (patientBloodType == O && !validO)
    {
            compatibleBlood := false;
    }
    if (patientBloodType == O && validO)
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && validA)
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && !validA && validO)
    {
        compatibleBlood := true;
    }
    if (patientBloodType == A && !validA && !validO)
    {
        compatibleBlood := false;
    }
    if (patientBloodType == B && validB)
    {
        compatibleBlood := true;
    }
    if (patientBloodType == B && !validB && validO)
    {
        compatibleBlood := true;
    }
    if (patientBloodType == B && !validB && !validO)
    {
        compatibleBlood := false;
    }
    if (patientBloodType == AB && validAB)
    {
        compatibleBlood := true;
    }
}

method doesExist(bType: BloodType, a:array<BloodRecord>) returns (Exists: bool)
    requires a != null
    ensures Exists == true ==> exists k :: 0 <= k < a.Length && a[k].bType == bType
{
    var i := 0;
    Exists := false;
    while (i < a.Length)
        decreases a.Length - i
        invariant 0 <= i <= a.Length
        invariant Exists == true ==> exists k :: 0 <= k < i && a[k].bType == bType 
    {
        if (a[i].bType == bType)
        {
            Exists := true;
        }

        i := i + 1;
    }
}

// predicate doesExistPredicate(bType: BloodType, a:array<BloodRecord>)
//     reads a
// {
//     exists k :: 0 <= k < a.Length && a[k].bType == bType
// }

predicate compatibleBloodExists(bType: BloodType, a:array<BloodRecord>)
    reads a
{ match(bType)
    { 
        case O => exists i :: 0 <= i < a.Length && a[i].bType == O
        case A => exists i :: 0 <= i < a.Length && (a[i].bType == O || a[i].bType == A)
        case B => exists i :: 0 <= i < a.Length && (a[i].bType == O || a[i].bType == B)
        case AB => exists i :: 0 <= i < a.Length && (a[i].bType == O || a[i].bType == A || a[i].bType == B || a[i].bType == AB)
    }
}