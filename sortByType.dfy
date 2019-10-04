datatype BloodRecord = BloodRecord(blood: char, location: string, donationDate: string, expiryDate: string)

predicate perm(a:array<BloodRecord>, b:array<BloodRecord>)
requires a!= null && b!= null
reads a,b
{
    multiset(a[..]) == multiset(b[..])
}
predicate sorted(a:array<BloodRecord>, min:int, max:int)
requires a != null
requires 0 <= min <= max <= a.Length
reads a
{
    forall i,j | min <= i < j < max :: a[i].blood <= a[j].blood
}

method sortByBloodType(a:array<BloodRecord>)
requires a != null
requires a.Length >= 1
modifies a
ensures perm(a,old(a))
ensures sorted(a,0,a.Length)
{
    var i := 1;
    while i < a.Length
    invariant perm(a,old(a))
    invariant i <= i <= a.Length
    invariant sorted(a, 0, i)
    decreases a.Length - i
    {
        var j := i;
        while j > 0 && a[j-1].blood > a[j].blood
        invariant perm(a,old(a))
        invariant 1 <= i <= a.Length
        invariant 0 <= j <= i
        invariant sorted(a,0,j)
        invariant sorted(a,j,i+1)
        invariant forall m,n | 0 <= m < j < n <= i :: a[m].blood <= a[n].blood
        decreases j
        {
            a[j],a[j-1] := a[j-1],a[j];
            j := j - 1;
        }
        i := i + 1;
    }
}

method swap (a: array<BloodRecord>, i:int, j:int)
modifies a;
requires a!= null;
requires 0 <= i <= j < a.Length;
ensures (a[i] == old(a[j]) && a[j] == old(a[i]))
ensures forall p :: 0<=p<a.Length && p!=i && p!=j ==> a[p] == old(a[p])
{
    a[i],a[j] := a[j],a[i];
}
