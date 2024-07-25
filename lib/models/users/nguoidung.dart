class User {
  final String _cccd;
  final String _ho;
  final String _ten;
  final DateTime _ngaySinh;
  final int _gioiTinh;
  final String _diaChi;
  final String _tenDangNhap;

  User({
    required String cccd,
    required String ho,
    required String ten,
    required DateTime ngaySinh,
    required int gioiTinh,
    required String diaChi,
    required String tenDangNhap,
  }) : _cccd = cccd, _ho = ho,_ten = ten,_ngaySinh = ngaySinh, _gioiTinh = gioiTinh
  ,_diaChi = diaChi, _tenDangNhap = tenDangNhap;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cccd: json['CCCD'],
      ho: json['Ho'],
      ten: json['Ten'],
      ngaySinh: DateTime.parse(json['NgaySinh']),
      gioiTinh: json['GioiTinh'],
      diaChi: json['DiaChi'],
      tenDangNhap: json['TenDangNhap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CCCD': _cccd,
      'Ho': _ho,
      'Ten': _ten,
      'NgaySinh': _ngaySinh.toIso8601String(),
      'GioiTinh': _gioiTinh,
      'DiaChi': _diaChi,
      'TenDangNhap': _tenDangNhap,
    };
  }
}
