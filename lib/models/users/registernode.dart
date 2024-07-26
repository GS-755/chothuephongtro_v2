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
      'TenDangNhap': this._tenDangNhap,
      'MatKhau': this._matKhau,
      'Email': this._email,
      'SoDT': this._soDt,
      'MaVaiTro': this._maVaiTro
    };
  }
}
