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
    // Check Type O Compatibility
    if (patientBloodType == O)
    {
        compatibleBlood := doesExist(O, a);
    }

    // Check Type A Compatibility
    else if (patientBloodType == A)
    {
        var existsA := doesExist(A, a);
        var existsO := doesExist(O, a);
        compatibleBlood := (existsA || existsO);
    }

    // Check type B Compatibility
    else if (patientBloodType == B)
    {
        var existsB := doesExist(B, a);
        var existsO := doesExist(O, a);
        compatibleBlood := (existsB || existsO);
    }

    // Check AB Compatibility
    else if (patientBloodType == AB)
    {
        var existsA := doesExist(A, a);
        var existsB := doesExist(B, a);
        var existsAB := doesExist(AB, a);
        var existsO := doesExist(O, a);
        compatibleBlood := (existsA || existsB || existsAB || existsO);
    }
}

method doesExist(bType: BloodType, a:array<BloodRecord>) returns (Exists: bool)
    requires a != null
    ensures Exists == exists k :: 0 <= k < a.Length && a[k].bType == bType
{
    var i := 0;
    Exists := false;
    while (i < a.Length)
        decreases a.Length - i
        invariant 0 <= i <= a.Length
        invariant Exists == exists k :: 0 <= k < i && a[k].bType == bType
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