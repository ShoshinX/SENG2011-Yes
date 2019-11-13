method merge(s1:seq<int>, s2:seq<int>) returns(s3: seq<int>)
requires sorted(s1) && sorted(s2)
requires |s1| > 0 && |s2| > 0
ensures sorted(s3)
ensures |s3| == |s1| + |s2|
{
  s3 := [];
  var j, k;
  j, k := 0, 0;
  
  while j < |s1| && k < |s2|
  decreases (|s1| + |s2|) - (j + k)
  invariant sorted(s3)
  invariant 0 <= j <= |s1| && 0 <= k <= |s2|
  invariant |s3| == j + k
  invariant j < |s1| && k < |s2| ==> forall l :: 0 <= l < |s3| ==> s3[l] <= s1[j] && s3[l] <= s2[k]
  invariant j < |s1| && k < |s2| && s1[j] <= s2[k] ==> forall n, m :: j <= n < |s1| && k <= m < |s2| ==> s1[j] <= s1[n] && s1[j] <= s2[m]
  invariant j < |s1| && k < |s2| && s2[k] < s1[j] ==> forall n, m :: j <= n < |s1| && k <= m < |s2| ==> s2[k] < s1[n] && s2[k] <= s2[m]
  invariant j >= |s1| && k < |s2| ==> forall o :: k <= o < |s2| ==> s2[o] >= s3[|s3|-1]
  invariant k >= |s2| && j < |s1| ==> forall o :: j <= o < |s1| ==> s1[o] >= s3[|s3|-1]
  {
    if(s1[j] <= s2[k])
    {
      s3 := s3 + s1[j..j+1];
      j := j + 1;
    }
    else
    {
      s3 := s3 + s2[k..k+1];
      k := k + 1;
    }
  }
  
  if(j >= |s1| && k < |s2|)
  {
    s3 := s3 + s2[k..];
  }
  if(k >= |s2| && j < |s1|)
  {
    s3 := s3 + s1[j..];
  }
  
}

predicate sorted(s: seq<int>) 
{
  forall j,k :: 0 <= j < k < |s| ==> s[j] <= s[k]
}

