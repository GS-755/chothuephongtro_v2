class VaiTro {
  final int _maVaiTro;
  final String _tenVaiTro;

  VaiTro({required int maVaiTro,
    required String tenVaiTro,})
      : _maVaiTro = maVaiTro, _tenVaiTro = tenVaiTro;

  factory VaiTro.fromJson(Map<String, dynamic> json) {
    return VaiTro(
      maVaiTro: json['MaVaiTro'],
      tenVaiTro: json['TenVaiTro'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaVaiTro': _maVaiTro,
      'TenVaiTro': _tenVaiTro,
    };
  }
}
