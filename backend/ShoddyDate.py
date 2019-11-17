
class SDate:
    def __init__(self, dd, mm, yy):
        if(dd < 0 ):
            raise ValueError('Day provided cannot be < 0.')
        if(dd >= 31 ):
            raise ValueError('Day provided cannot be >= 31. Note that date is counted from 0.')
        if(mm < 0 ):
            raise ValueError('Month provided cannot be < 0.')
        if(mm >= 12):
            raise ValueError('Month provided cannot be >= 12. Note that date is counted from 0.')
        if(yy < 0): 
            raise ValueError('Year provided cannot be < 0.')
        self.day = dd
        self.month = mm
        self.year = yy

    # overloading lessThan
    def __lt__(self, p2):
        dayComparator = p2.day > self.day
        monthComparator = (p2.month > self.month) or (dayComparator and (p2.month == self.month))
        yearComparator = (p2.year > self.year) or (monthComparator and p2.year == self.year)
        return yearComparator
    
    def __gt__(self, p2):
        return p2 < self

    def __le__(self, p2):
        return !(self > p2)

    def __ge__(self, p2):
        return !(self < p2)
        
    def __eq__(self, p2):
        return !(self < p2 or self > p2)

    def toString(self):
        return str(self.year) + "-" + str(self.month) + "-" + str(self.day)
    
