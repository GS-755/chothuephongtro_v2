import 'package:chothuephongtro_v2/utils/emptystring.dart';

import 'nguoidung.dart';
import 'vaitro.dart';

class TaiKhoan {
  String _tenDangNhap = EmptyString.get();
  String _matKhau = EmptyString.get();
  String _email = EmptyString.get();
  String _soDT = EmptyString.get();
  String _strAvatar = EmptyString.get();
  String _base64Avatar = EmptyString.get();
  int _maVaiTro = 0;
  VaiTro _vaiTro = new VaiTro();
  User _user = new User();

  TaiKhoan();
  TaiKhoan.fullInit(
      this._tenDangNhap,
      this._matKhau,
      this._email,
      this._soDT,
      this._strAvatar,
      this._base64Avatar,
      this._maVaiTro,
      this._vaiTro,
      this._user
  );

  // Getter
  String get tenDangNhap => _tenDangNhap;
  String get matKhau => this._matKhau;
  String get email => this._email;
  String get soDT => this._soDT;
  String get strAvatar => this._strAvatar;
  String get base64Avatar => this._base64Avatar;
  int get maVaiTro => this._maVaiTro;
  VaiTro get vaiTro => this._vaiTro;
  User get user => this._user;
  // Setter
  set matKhau(String value) { this._matKhau = value; }
  set email(String value) { this._email = value; }
  set soDT(String value) { this._soDT = value; }
  set strAvatar(String value) { this._strAvatar = value; }
  set base64Avatar(String value) { this._base64Avatar = value; }
  set maVaiTro(int value) { this._maVaiTro = value; }
  set vaiTro(VaiTro value) { this._vaiTro = value; }
  set user(User value) { this._user = value; }

  set tenDangNhap(String value) {
    _tenDangNhap = value;
  }

  factory TaiKhoan.fromJson(Map<String, dynamic> json) {
    return TaiKhoan.fullInit(
        json['TenDangNhap'],
        json['MatKhau'],
        json['Email'],
        json['SoDT'],
        json['StrAvatar'],
        EmptyString.get(),
        json['MaVaiTro'],
        json['VaiTro'],
        json['User']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'VaiTro': _vaiTro.toJson(),
      'TenDangNhap': _tenDangNhap,
      'MatKhau': _matKhau,
      'Email': _email,
      'SoDT': _soDT,
      'StrAvatar': _strAvatar,
      'Base64Avatar': _base64Avatar,
      'MaVaiTro': _maVaiTro,
      'User': _user.toJson(),
    };
  }
}
