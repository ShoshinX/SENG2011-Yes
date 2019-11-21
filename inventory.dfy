include "bloodRep.dfy"
module inventory {
    import BR = BloodRep
    class Quack<Data>
    {
        var buf: array<Data>
        var m: int, n: int;
        ghost var shadow: seq<Data>;

        predicate Valid() reads this, this.buf
        { 
            buf != null && buf.Length != 0 && 0 <= m <= n <= buf.Length && shadow==buf[m..n]  
        }

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

        predicate isEmpty()
        reads this
        {
          shadow == []
        }

        method Empty() returns (x:bool)
        ensures x <==> isEmpty() 
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
/*
        method HeadTail()
        modifies this, this.buf;
        requires buf!=null
        requires shadow != [];
        requires Valid(); ensures Valid();
        ensures |shadow| == old(|shadow|)
        ensures |shadow| > 1 ==> shadow == [old(shadow[|old(shadow)|-1])] + old(shadow[1..|old(shadow)|-1]) + [old(shadow[0])]
        ensures |shadow| <= 1 ==> shadow == old(shadow)
        ensures buf == old(buf)
        {
            buf[m], buf[n-1] := buf[n-1],buf[m];
            if(|shadow| > 1)
            {
                shadow := [shadow[|shadow|-1]] + shadow[1..|shadow|-1] + [shadow[0]];
            } 
        }   
*/
    }

    class Inventory
    {
        var A : Quack<BR.BloodRecord>;
        var B : Quack<BR.BloodRecord>;
        var AB : Quack<BR.BloodRecord>;
        var O : Quack<BR.BloodRecord>;

        /*
         * Valid() to make sure that A,B,AB,O are instantiated 
         */
        predicate Valid()
        reads this, this.A, this.B, this.AB, this.O
        {
            A != null && A.buf != null && A.buf.Length != 0 &&
            B != null && B.buf != null && B.buf.Length != 0 &&
            AB != null && AB.buf != null && AB.buf.Length != 0 &&
            O != null && O.buf != null && O.buf.Length != 0
        }

        /*
         * to make sure that the groups are grouped correctly
         */
        predicate ValidGroup()
        requires Valid()
        reads this, this.A, this.A.buf, this.B, this.B.buf ,this.AB, this.AB.buf ,this.O, this.O.buf;
        { 
            (forall i :: 0 <= A.m <= i < A.n <= A.buf.Length ==> BR.typeMatch(A.buf[i], BR.BloodType.A) ) &&
            (forall i :: 0 <= B.m <= i < B.n <= B.buf.Length ==> BR.typeMatch(B.buf[i], BR.BloodType.B)) &&
            (forall i :: 0 <= AB.m <= i < AB.n <= AB.buf.Length ==> BR.typeMatch(AB.buf[i], BR.BloodType.AB)) &&
            (forall i :: 0 <= O.m <= i < O.n <= O.buf.Length ==> BR.typeMatch(O.buf[i], BR.BloodType.O))
        }

        constructor() modifies this
        ensures fresh(A) && fresh(B) && fresh(AB) && fresh(O);
        ensures A.buf != null && A.buf.Length != 0;
        ensures B.buf != null && B.buf.Length != 0;
        ensures AB.buf != null && AB.buf.Length != 0;
        ensures O.buf != null && O.buf.Length != 0;
        ensures Valid() && ValidGroup();
        {
            A := new Quack(1); assert A.buf != null && A.buf.Length != 0;
            B := new Quack(1); assert B.buf != null && B.buf.Length != 0;
            AB := new Quack(1); assert AB.buf != null && AB.buf.Length != 0;
            O := new Quack(1); assert O.buf != null && O.buf.Length != 0;
        }
        method Empty(t:BR.BloodType) returns (x:bool)
        modifies this.A, this.B, this.AB, this.O;
        requires Valid() && ValidGroup();ensures Valid()&& ValidGroup();
        requires A.Valid() && B.Valid() && AB.Valid() && O.Valid(); ensures A.Valid() && B.Valid() && AB.Valid() && O.Valid();
        {
            match (t)
            {
                case A => x:= this.A.Empty();
                case B => x:= this.B.Empty();
                case AB => x:= this.AB.Empty();
                case O => x:= this.O.Empty();
            }
        }
        method Pop(t:BR.BloodType) returns(x: BR.BloodRecord) modifies this, this`A, this`B, this`AB, this`O
        requires Valid() && ValidGroup();ensures Valid() && ValidGroup();
        requires A.Valid() && B.Valid() && AB.Valid() && O.Valid(); ensures A.Valid() && B.Valid() && AB.Valid() && O.Valid();
        modifies this.A, this.B, this.AB, this.O

	method Qop(t:BR.BloodType) returns (x: BR.BloodRecord) modifies this,
this`A, this`B, this`AB, this`O
        requires Valid() && ValidGroup();ensures Valid()&& ValidGroup();
        requires A.Valid() && B.Valid() && AB.Valid() && O.Valid(); ensures A.Valid() && B.Valid() && AB.Valid() && O.Valid();

        method Push(t:BR.BloodType, x:BR.BloodRecord) modifies this, this`A, this`B, this`AB, this`O
        requires Valid() && ValidGroup();ensures Valid()&& ValidGroup();
        requires A.Valid() && B.Valid() && AB.Valid() && O.Valid(); ensures A.Valid() && B.Valid() && AB.Valid() && O.Valid();
        requires t == BR.BloodType.A <==> BR.typeMatch(x,BR.BloodType.A);
        requires t == BR.BloodType.B <==> BR.typeMatch(x, BR.BloodType.B);
        requires t == BR.BloodType.AB <==> BR.typeMatch(x,BR.BloodType.AB);
        requires t == BR.BloodType.O <==> BR.typeMatch(x, BR.BloodType.O);
        //{
        //    match (t)
        //    {
        //        case A => this.A.Push(x);
        //        case B => this.B.Push(x);
        //        case AB => this.AB.Push(x);
        //        case O => this.O.Push(x);
        //    }
        //}


        method HeadTail()
        requires Valid() && ValidGroup();ensures Valid()&& ValidGroup();
        requires A.Valid() && B.Valid() && AB.Valid() && O.Valid(); ensures A.Valid() && B.Valid() && AB.Valid() && O.Valid();

	method CompatibleBloodExists(bType:BR.BloodType) returns(b:bool)
        requires Valid() && ValidGroup();ensures Valid()&& ValidGroup();
        ensures bType == BR.BloodType.B  ==> b <==> !(this.B.isEmpty() && this.O.isEmpty())
        ensures bType == BR.BloodType.A  ==> b <==> !(this.A.isEmpty() && this.O.isEmpty())
        ensures bType == BR.BloodType.AB ==> b <==> !(this.A.isEmpty() && this.O.isEmpty() && this.O.isEmpty() && this.O.isEmpty())
        ensures bType == BR.BloodType.O  ==> b <==> !(this.O.isEmpty())
        { 
            match(bType)
            {
                case A => 
                { 
                    var existsA := this.A.Empty();
                    existsA := !existsA;
                    var existsO := this.O.Empty();
                    existsO := !existsO;
                    b := existsA && existsO;
                }
                case B => 
                { 
		    var existsB := this.B.Empty();
		    existsB := !existsB;
		    var existsO := this.O.Empty();
		    existsO := !existsO;
		    b := existsB && existsO;
                }
                case AB => 
                { 
		    var existsA := this.A.Empty();
		    existsA := !existsA;
		    var existsB := this.B.Empty();
		    existsB := !existsB;
		    var existsO := this.O.Empty();
		    existsO := !existsO;
		    b := existsA && existsB && existsO;
                }
                case O => 
                { 
		    var existsO := this.O.Empty();
		    existsO := !existsO;
		    b := existsO;
                }
            }
            b := false;
        }

    }

}

