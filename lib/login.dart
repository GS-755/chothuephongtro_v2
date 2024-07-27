import 'dart:convert';

import 'package:chothuephongtro_v2/models/users/loginnode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _moveToRegisterPage() {
    Navigator.of(context).pushReplacementNamed('/login/register');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header đăng nhập
              Container(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đăng nhập tài khoản',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text (
                      'Hoặc đăng nhập bằng SSO',
                      style: TextStyle(
                          color: Color.fromRGBO(81, 81, 81, 100)
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                )
              ),
              // Mục chọn đăng nhập SSO
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nút được nhấn
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/login/img_google.png', height: 24.0),
                            const SizedBox(width: 8.0),
                            const Text(
                              'Google',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 24.0),
              // Form nhập tài khoản & mật khẩu
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tên đăng nhập',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0)
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: const Color.fromRGBO(85, 101, 255, 100),
                          minimumSize: const Size.fromHeight(32.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontStyle: FontStyle.normal
                          ),
                        )
                    ),
                    const SizedBox(height: 48.0),
                  ],
                ),
              ),
              // Đăng ký
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chưa có tài khoản?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: _moveToRegisterPage,
                    child: const Text(
                      'Đăng ký ngay',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    LoginNode loginNode = LoginNode(username, password);
    final apiUrl = Uri.parse("${dotenv.env['API_URL']!.trim()}/accounts/login");
    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userName': loginNode.userName,
          'password': loginNode.password,
        }),
      );
      if (response.statusCode == 200) {
        // Đăng nhập thành công
        print('[login.dart] Đăng nhập thành công');
        Navigator.of(context).pushReplacementNamed('/user/index');
      } else {
        // Đăng nhập thất bại
        print('[login.dart] Đăng nhập thất bại');
      }
    } catch (e) {
      // Xử lý lỗi
      print('[login.dart] Lỗi khi đăng nhập:\n $e');
    }
  }
}