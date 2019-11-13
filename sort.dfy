include "merge.dfy"

method mergeSort(s: seq<int>) returns(sortedS: seq<int>)
requires |s| > 0
ensures sorted(sortedS)
ensures |sortedS| == |s|
{
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
    
    lseq := mergeSort(topcp);
    rseq := mergeSort(botcp);
    
    // merging the sorted half sequences
    sortedS := merge(lseq, rseq);
    assert sorted(sortedS);
    assert |sortedS| == |s|;
    
    return sortedS;
  }
  else
  {
    // base cases for single item and two items
    // single item just return
    if(|s| == 1) {return s;}
    // sort the two items and return
    if(|s| == 2)
    {
      if(s[0] <= s[1]) 
      {
        sortedS := [s[0], s[1]];
      }
      else
      {
        sortedS := [s[1], s[0]];
      }
    }
  }
}

method Main() {
  var s :seq<int>;
  
  s := [1,7,3,8,12,9,5,3,2];
  
  var sortedS := mergeSort(s);
  
  print sortedS[..], '\n';
}
