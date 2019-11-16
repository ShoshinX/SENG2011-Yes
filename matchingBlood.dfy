include "bloodRep.dfy"
include "dateRep.dfy"
import B = BloodRep
  import D = DateRep
datatype BloodType = A | B | AB | O // A = 0, B = 1, AB = 2, O = 3
datatype BloodRecord = BloodRecord(bType: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)


method GetCompatibleBlood(patientBloodType: BloodType, a:array<BloodRecord>) returns (compatibleBlood: BloodRecord)
    requires a != null && a.Length > 0
    requires compatibleBloodExists(patientBloodType, a)
    ensures isCompatible(compatibleBlood.bType, patientBloodType)
{
    var i := 0;
    while (i < a.Length)
        decreases a.Length - i
        invariant 0 <= i <= a.Length
        invariant forall k :: 0 <= k < i ==> !isCompatible(patientBloodType, a[k].bType)
    {
        if ((patientBloodType == O && a[i].bType == O) ||
        (patientBloodType == A && (a[i].bType == O || a[i].bType == A)) ||
        (patientBloodType == B && (a[i].bType == O || a[i].bType == B)) ||
        (patientBloodType == AB && (a[i].bType == O || a[i].bType == A || a[i].bType == B || a[i].bType == AB)))
        {
            compatibleBlood := a[i];
            return;
        }
        i := i + 1;
    }
}

method CompatibleBloodExists(patientBloodType: BloodType, a:array<BloodRecord>) returns (compatibleBlood: bool)
    requires a != null && a.Length > 0
    ensures compatibleBlood == compatibleBloodExists(patientBloodType, a)
{
    // Check Type O Compatibility
    if (patientBloodType == O)
    {
        compatibleBlood := DoesExist(O, a);
    }

    // Check Type A Compatibility
    else if (patientBloodType == A)
    {
        var existsA := DoesExist(A, a);
        var existsO := DoesExist(O, a);
        compatibleBlood := (existsA || existsO);
    }

    // Check type B Compatibility
    else if (patientBloodType == B)
    {
        var existsB := DoesExist(B, a);
        var existsO := DoesExist(O, a);
        compatibleBlood := (existsB || existsO);
    }

    // Check AB Compatibility
    else if (patientBloodType == AB)
    {
        var existsA := DoesExist(A, a);
        var existsB := DoesExist(B, a);
        var existsAB := DoesExist(AB, a);
        var existsO := DoesExist(O, a);
        compatibleBlood := (existsA || existsB || existsAB || existsO);
    }
}

method DoesExist(bType: BloodType, a:array<BloodRecord>) returns (Exists: bool)
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

predicate isCompatible(bType1: BloodType, bType2: BloodType)
{ match(bType1)
    {
        case O => bType2 == O
        case A => bType2 == O || bType2 == A
        case B => bType2 == O || bType2 == B
        case AB => bType2 == O || bType2 == AB
    }
}

