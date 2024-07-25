import 'nguoidung.dart';
import 'vaitro.dart';

class TaiKhoan {
  final VaiTro _vaiTro;
  final String _tenDangNhap;
  final String _matKhau;
  final String _email;
  final String _soDT;
  final String _strAvatar;
  final String _base64Avatar;
  final int _maVaiTro;
  final User _user;

  TaiKhoan({
    required VaiTro vaiTro,
    required String tenDangNhap,
    required String matKhau,
    required String email,
    required String soDT,
    required String strAvatar,
    required String base64Avatar,
    required int maVaiTro,
    required User user,
  }) : _vaiTro = vaiTro, _tenDangNhap = tenDangNhap, _matKhau = matKhau,
        _email = email,_soDT = soDT,_strAvatar = strAvatar,_base64Avatar = base64Avatar,
        _maVaiTro = maVaiTro,_user = user;

  factory TaiKhoan.fromJson(Map<String, dynamic> json) {
    return TaiKhoan(
      vaiTro: VaiTro.fromJson(json['VaiTro']),
      tenDangNhap: json['TenDangNhap'].trim(),
      matKhau: json['MatKhau'],
      email: json['Email'].trim(),
      soDT: json['SoDT'].trim(),
      strAvatar: json['StrAvatar'],
      base64Avatar: json['Base64Avatar'],
      maVaiTro: json['MaVaiTro'],
      user: User.fromJson(json['User']),
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
