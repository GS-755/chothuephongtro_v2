class TTGiaoDich {
  int MaTTGD;
  String TenTTGD;

  TTGiaoDich({
    required this.MaTTGD,
    required this.TenTTGD,
  });

  factory TTGiaoDich.fromJson(Map<String, dynamic> json) {
    return TTGiaoDich(
      MaTTGD: json['MaTTGD'],
      TenTTGD: json['TenTTGD'],
    );
  }
}
