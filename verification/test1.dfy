module bloodRep{
    datatype Date = Date(day:int, month:int, year:int)
    datatype BloodType = O | A | B | AB
    datatype BloodRecord = BloodRecord(bloodType: BloodType, prod: Date, exp: Date, isFresh: bool)

    predicate validDate(d: Date)
    {1 <= d.day <= 30 && 1 <= d.month <= 12 && d.year >= 0 }

    method newDate(day:int, month:int, year:int) returns (d: Date)
    requires 1 <= day <= 30
    requires 1 <= month <= 12
    requires year >= 0
    ensures validDate(d)
    {
        d := Date(day, month, year);
    }
    method compareDateLess(d1: Date, d2: Date) returns (b: bool)
    requires validDate(d1) && validDate(d2)
    ensures b ==> d1.year < d2.year || d1.month < d2.month || d1.day <= d2.day
    {
        b := true;
        if (d1.year > d2. year)
        { b:= false; }
        if (d1.month > d2.month)
        { b:= false; }
        if (d1.day >= d2.day)
        { b:= false; }
    }

    method doesExist(bType: BloodType, a:array<BloodRecord>) returns (Exists: bool)
        requires a != null
        ensures Exists == exists k :: 0 <= k < a.Length && a[k].bloodType == bType
    {
        var i := 0;
        Exists := false;
        while (i < a.Length)
            decreases a.Length - i
            invariant 0 <= i <= a.Length
            invariant Exists == exists k :: 0 <= k < i && a[k].bloodType == bType
        {
            if (a[i].bloodType == bType)
            {
                Exists := true;
            }

            i := i + 1;
        }
    }


    method addBloodRecord(a: array<BloodRecord>, bloodType: BloodType, prod: Date, exp: Date, isFresh: bool)
    requires a != null;
    
    

}