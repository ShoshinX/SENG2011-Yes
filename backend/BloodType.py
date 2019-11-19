from enum import Enum

class BloodType(Enum):
  A = 0
  B = 1
  AB = 2
  O = 3

  '''
  Transform BloodType Strings into BloodType Enums
  To Transfer back to BloodType Strings <BloodType>.name eg. A.name
  '''
  @classmethod
  def FromStrToEnum(cls,str):
    if str == 'A':
      return cls.A
    elif str == 'B':
      return cls.B
    elif str == 'AB':
      return cls.AB
    else:
      return cls.O
    
