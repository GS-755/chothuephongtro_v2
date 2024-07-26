class ViTri {
  // Private attributes
  final int _MaVT;
  final String _Quan;
  final String _HinhAnh;

  // Constructor
  ViTri({
    required int MaVT,
    required String Quan,
    required String HinhAnh,
  })  : _MaVT = MaVT,
        _Quan = Quan,
        _HinhAnh = HinhAnh;

  // Getters
  int get MaVT => _MaVT;
  String get Quan => _Quan;
  String get HinhAnh => _HinhAnh;

  Map<String, dynamic> toJson() =>
      {'MaVT': _MaVT, 'Quan': _Quan, 'HinhAnh': _HinhAnh};
  factory ViTri.fromJson(Map<String, dynamic> json) {
    return ViTri(
        MaVT: json['MaVT'], Quan: json['Quan'], HinhAnh: json['HinhAnh']);
  }
}
