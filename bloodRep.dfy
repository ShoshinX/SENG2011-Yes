module BloodRep {
  import D = DateRep
  datatype BloodType = A | B | AB | O
  datatype BloodRecord = BloodRecord(blood: BloodType, location: string, donationDate: D.Date, expiryDate: D.Date)
}
