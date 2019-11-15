from Merge import merge
def mergeSort(seq):
    if (len(seq) > 2):
        if (len(seq) % 2 == 0):
            mid = int(len(seq) / 2)
        else:
            mid = int((len(seq) + 1) / 2)

        topcp = seq[:mid]
        botcp = seq[mid:]
        
        lSeq = mergeSort(topcp)
        rSeq = mergeSort(botcp)

        return merge(lSeq,rSeq)
    else:
        if (len(seq) == 1):
            return seq
        if (len(seq) == 2):
            if(seq[0].expiryDate.__lt__(seq[1].expiryDate)):
                return [seq[0],seq[1]]
            else:
                return [seq[1],seq[0]]


        
        