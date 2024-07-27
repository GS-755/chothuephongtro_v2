class RegisterNode {
  final String _tenDangNhap;
  final String _matKhau;
  final String _email;
  final String _soDt;
  final int _maVaiTro;

  RegisterNode(this._tenDangNhap, this._matKhau, this._email, this._soDt,
      this._maVaiTro);

  Map<String, dynamic> toJson() {
    return {
      'TenDangNhap': _tenDangNhap,
      'MatKhau': _matKhau,
      'Email': _email,
      'SoDT': _soDt,
      'MaVaiTro': _maVaiTro
    };
  }
}
