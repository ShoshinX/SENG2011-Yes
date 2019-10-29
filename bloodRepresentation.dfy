module BloodRep {
  import Date = DateRep
  datatype BloodType = A | B | AB | O
  datatype BloodRecord = BloodRecord(blood: BloodType, location: string, donationDate: DateRep.Date, expiryDate: DateRep.Date)
}
