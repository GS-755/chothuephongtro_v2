class LoaiGiaoDich {
  int MaLoaiGD;
  String TenLoaiGD;

  LoaiGiaoDich({
    required this.MaLoaiGD,
    required this.TenLoaiGD,
  });

  factory LoaiGiaoDich.fromJson(Map<String, dynamic> json) {
    return LoaiGiaoDich(
      MaLoaiGD: json['MaLoaiGD'],
      TenLoaiGD: json['TenLoaiGD'],
    );
  }
}
