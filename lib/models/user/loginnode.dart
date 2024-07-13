class LoginNode {
  late String _userName;
  late String _password;

  LoginNode(String userName, String password) {
    _userName = userName;
    _password = password;
  }

  String get userName => _userName;
  String get password => _password;

  set userName(String value) { _userName = value; }
  set password(String value) { _password = value; }
}
