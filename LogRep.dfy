module LogRep{
  // implementation-wise logs are represented as a tuple (date, result/bloodrecord)
  // verifying adding a log since logging is done via system after another method and not user
  predicate sorted(Log: seq<int>)
  {
    forall i,j :: 0 <= i < j < |Log| ==> Log[i] <= Log[j]
  }

  method initLog() returns( list: seq<int>)
  {
    list := [];
  }

  method addLog(list: seq<int>, log: int) returns(newLog: seq<int>)
    ensures newLog == list + [log]
    ensures |newLog| == |list| + 1
    ensures log in newLog
  {
    newLog := list + [log];
  }

  method Test()
  {
    var Log := initLog();
    var entry1 := 0107;
    var entry2 := 0108;
    var entry3 := 0308;

    Log := addLog(Log, entry1);
    assert Log[|Log| - 1 ] == 0107;

    Log := addLog(Log, entry2);
    assert Log[|Log| - 1 ] == 0108;
    assert Log[|Log| - 2 ] == 0107;

    Log := addLog(Log, entry3);
    assert Log[|Log| - 1 ] == 0308;
    assert Log[|Log| - 2 ] == 0108;
    assert Log[|Log| - 3 ] == 0107;
  }
}
