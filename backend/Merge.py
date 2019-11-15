
# Assume sorted, idk what to do
def merge(s1, s2):
  s3 = []
  j = 0
  k = 0

  while (j < len(s1) and k < len(s2)):
    if (s1[j] <= s2[k]):
      s3 = s3+s1[j:j+1]
      j = j+1
    else:
      s3 = s3 + s2[k:k+1]
      k = k+1
  
  if (j >= len(s1) and k < len(s2)):
    s3 = s3 + s2[k:]
  if (k >= len(s2) and j < len(s1)):
    s3 = s3 + s1[j:]

  return s3
