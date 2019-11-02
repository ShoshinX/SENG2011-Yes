/*
method SortByBloodType(a: array<br.BloodRecord>) returns(a: array<br.BloodRecord)
requires a != null
{

}

method SortByExpDate(a: array<br.BloodRecord>) returns(a: array<br.BloodRecord)
requires a != null
{
  
}
*/

// sortBy to indicate what we are sorting by
// 1 for blood type
// 2 for location
// 3 for production date
// 4 for expiry date
method mergeSort(s: seq<br.BloodRecord>, sortBy: int) returns(sortedS: seq<br.BloodRecord>)
{
  // base cases for single item and two items
  // single item just return
  if(|s| == 1) {return s;}
  // sort the two items and return
  if(|s| == 2)
  {
    var left, right;
    if(sortBy == 1)
    {
      var bt1, bt2;
      bt1 := br.getBloodType(s[0]);
      bt2 := br.getBloodType(s[1]);
      left := br.getBTasInt(bt1);
      right := br.getBTasInt(bt2);
    }
    if(sortBy == 2)
    {
      left := br.getLocation(s[0]);
      right := br.getLocation(s[1]);
    }
    if(left < right) 
    {
      sortedS := [s[0], s[1]];
    }
    else
    {
      sortedS := [s[1], s[0]];
    }
  }
  // break sequence by slicing at midpoint and recursively mergesort them
  if(|s| > 2)
  {
    var mid:int;
    if(|s| % 2 == 0) {mid := |s|/2;}
    else {mid := (|s|+1)/2;}

    // get top half and bottom half into temporary copies
    var topcp, botcp;

    topcp := s[..mid];
    botcp := s[mid..];

    // gets the sorted half sequences from recursive calls    
    var lseq, rseq;
    
    lseq := mergeSort(topcp, sortBy);
    rseq := mergeSort(botcp, sortBy);
    
    // merging the sorted half sequences
    var i, j, k;
    i, j, k := 0, 0, 0;
    while i < |lseq| + |rseq|
    invariant 0 <= i <= |lseq| + |rseq|
    {
      // reach the end of one sequence so the rest of the other
      // sequence can be appended onto the end of the sorted sequence
      if(j >= |lseq| || k >= |rseq|)
      {
        if(j >= |lseq| && k < |rseq|)
        {
          sortedS := sortedS + rseq[k..];
        }
        if(j < |lseq| && k >= |rseq|)
        {
          sortedS := sortedS + lseq[j..];
        }
        break;
      }
      // go through sequences and place items in order according to sortBy
      else
      {
        var litem, ritem;
        if(sortBy == 1)
        {
          var bt1, bt2;
          bt1 := br.getBloodType(lseq[j]);
          bt2 := br.getBloodType(rseq[k]);
          litem := br.getBTasInt(bt1);
          ritem := br.getBTasInt(bt2);
        }
        if(sortBy == 2)
        {
          litem := br.getLocation(lseq[j]);
          ritem := br.getLocation(rseq[k]);
        }
        if(litem <= ritem) 
        {
          sortedS := sortedS + lseq[j..j+1];
          j := j + 1;
        }
        else 
        {
          sortedS := sortedS + rseq[k..k+1];
          k := k + 1;
        }
      }
      i := i + 1;
    }
  }
}

import br = BloodRep

method Main() {
  
  var b1: br.BloodRecord, b2: br.BloodRecord, b3: br.BloodRecord, b4: br.BloodRecord, b5: br.BloodRecord;
  
  var bt1 := br.createBt(0);
  var bt2 := br.createBt(1);
  var bt3 := br.createBt(2);
  var bt4 := br.createBt(3);
  
  b1 := br.createBr(bt2, 1, 11, 11, 2011, 12, 12, 2012, true);
  b2 := br.createBr(bt1, 3, 10, 10, 2017, 11, 11, 2017, true);
  b3 := br.createBr(bt4, 6, 16, 10, 2015, 25, 3, 2016, true);
  b4 := br.createBr(bt3, 1, 10, 3, 2010, 18, 5, 2011, true);
  b5 := br.createBr(bt1, 2, 10, 2, 2014, 21, 10, 2014, true);
  
  var s: seq<br.BloodRecord> := [b1, b2, b3, b4, b5];

  assert s[0] == b1 && s[1] == b2 && s[2] == b3 && s[3] == b4 && s[4] == b5;
  
  printer(s);
  
  print '\n';
  
  var s2 := mergeSort(s, 1);
  
  printer(s2);
}

method printer(s: seq<br.BloodRecord>)
{
  var i := 0;
  while i < |s| {
    var bt, sbt, l, pro, exp;
    bt := br.getBloodType(s[i]);
    sbt := br.getBTasString(bt);
    l := br.getLocation(s[i]);
    pro := br.getProductionDate(s[i]);
    exp := br.getExpiryDate(s[i]);
    print sbt, ' ', l, ' ', pro, ' ', exp, '\n';
    i := i + 1;
  }
}





