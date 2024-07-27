class TTPhongTro {
  int MaTT;
  String TenTT;

  TTPhongTro({
    required this.MaTT,
    required this.TenTT,
  });

  factory TTPhongTro.fromJson(Map<String, dynamic> json) {
    return TTPhongTro(
      MaTT: json['MaTT'],
      TenTT: json['TenTT'],
    );
  }
}
