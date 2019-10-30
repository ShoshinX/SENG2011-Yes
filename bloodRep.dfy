module BloodRep {
  import D = DateRep
  datatype BloodType = A | B | AB | O
  datatype BloodRecord = BloodRecord(blood: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date, isOkay: bool)

  predicate typeValid(req: BloodType, ret: BloodType)
  {
    match req
    case A => (ret == A || ret == O)
    case B => (ret == B || ret == O)
    case O => (ret == O)
    case AB => (ret == AB || ret == A || ret == B || ret == O)
  }

}
