enum Operation { subtract, add }

// for this unit, you can add more if there is a need
enum Metric {
  litre,
  kg,
  unit,
}

enum NfcReadStatus {
  success,
  error,
  empty,
  notForApp,
  cancel,
}

enum NfcWriteStatus {
  success,
  error,
  overwrite,
  cancel,
}
