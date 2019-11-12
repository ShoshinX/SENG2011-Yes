include "bloodRep.dfy"
module inventory {
    class Quack<Data>
    {
        var buf: array<Data>
        var m: int, n: int;
        ghost var shadow: seq<Data>;

        predicate Valid() reads this, this.buf
        { buf != null && buf.Length != 0 && 0 <= m <= n <= buf.Length && shadow==buf[m..n] }

        constructor(size: int) modifies this
        requires size > 0;
        ensures shadow == [];
        ensures fresh(buf)
        ensures Valid()
        {
            buf := new Data[size];
            m,n := 0,0;
            shadow := [];
        }

        method Empty() returns (x:bool)
        ensures x <==> shadow == []
        requires Valid(); ensures Valid();
        { x := m==n; }

        method Pop() returns(x: Data) modifies this, this`n 
        requires buf != null && Valid()
        requires shadow != []
        ensures Valid();
        ensures x == old(shadow)[|old(shadow)|-1]
        ensures shadow == old(shadow)[..|old(shadow)|-1]
        ensures |shadow| == |old(shadow)| - 1
        ensures buf == old(buf)
        {
            x,n := buf[n-1], n-1;
            shadow := shadow[..|shadow|-1];
        }

        method Qop() returns (x: Data) modifies this, this`m
        requires buf != null && Valid()
        requires shadow != [];
        ensures Valid();
        ensures x == old(shadow[0])
        ensures shadow == old(shadow[1..])
        ensures |shadow| == |old(shadow)| - 1
        ensures buf == old(buf)
        {
            x,m := buf[m], m+1;
            shadow := shadow[1..];
        }

        method Push(x:Data) modifies this, this.buf,this`m, this`n
        requires buf != null && Valid()
        ensures shadow == old(shadow) + [x]
        ensures |shadow| == |old(shadow)| + 1
        ensures if old(n) == old(buf.Length) then fresh(buf) else buf == old(buf)
        ensures Valid();
        {
            if n==buf.Length
            {
                var b:= new Data[buf.Length];
                if m==0
                {
                    b := new Data[2*buf.Length];
                }
                forall (i | 0 <= i < n-m) { b[i] := buf[m+i]; }
                buf,m,n := b, 0, n-m;
            }
            buf[n],n := x, n+1;
            shadow := shadow + [x];
        }

    }

    class Inventory
    {
        
    }

}