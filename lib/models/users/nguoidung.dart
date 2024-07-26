import 'package:chothuephongtro_v2/utils/emptystring.dart';

class User {
  String _cccd = EmptyString.get();
  String _ho = EmptyString.get();
  String _ten = EmptyString.get();
  DateTime _ngaySinh = DateTime.now();
  int _gioiTinh = 1;
  String _diaChi = EmptyString.get();
  String _tenDangNhap = EmptyString.get();

  User();
  User.fullInit(this._cccd, this._ho, this._ten, this._ngaySinh, this._gioiTinh,
      this._diaChi, this._tenDangNhap);

  factory User.fromJson(Map<String, dynamic> json) {
    return User.fullInit(
      json['CCCD'],
      json['Ho'],
      json['Ten'],
      DateTime.parse(json['NgaySinh']),
      json['GioiTinh'],
      json['DiaChi'],
      json['TenDangNhap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CCCD': this._cccd,
      'Ho': this._ho,
      'Ten': this._ten,
      'NgaySinh': this._ngaySinh.toIso8601String(),
      'GioiTinh': this._gioiTinh,
      'DiaChi': this._diaChi,
      'TenDangNhap': this._tenDangNhap,
    };
  }
}
