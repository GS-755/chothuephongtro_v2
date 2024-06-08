class LoginNode {
  late String _userName;
  late String _password;

  LoginNode(String userName, String password) {
    this._userName = userName;
    this._password = password;
  }

  String get userName => this._userName;
  String get password => this._password;

  set userName(String value) { this._userName = value; }
  set password(String value) { this._password = value; }
}
