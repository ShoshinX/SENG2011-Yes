import sys
class Quack:
    def __init__(self,size):
        try:
            if size <= 0:
                raise Exception()
            else:
                self.buf = [None] * size
                self.m,self.n = 0,0
        except Exception as inst:
            print("initialising (infinity,0] size of quack", file=sys.stderr)

    def Empty(self):
        return self.m == self.n
    
    def Pop(self):
        # TODO make sure m and n are not equal
        x,self.n = self.buf[self.n-1], self.n - 1
        return x
    
    def Qop(self):
        # TODO make sure m and n are not equal
        x, self.m = self.buf[self.m], self.m+1
        return x

    def Push(self, x):
        if self.n == len(self.buf):
            b = [None] * len(self.buf)
            if self.m == 0:
                b = [None] * (len(self.buf)*2)
            for i in range(0,self.n - self.m):
                b[i] = self.buf[self.m + i]
        self.buf[self.n],self.n = x, self.n + 1
    
    def HeadTail(self):
        # TODO make sure m and n are not equal
        self.buf[self.m], self.buf[self.n-1] = self.buf[self.n-1], self.buf[self.m]

