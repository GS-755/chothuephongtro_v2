import 'dart:ui';
import 'dart:convert';
import 'package:chothuephongtro_v2/models/users/registernode.dart';
import 'package:http/http.dart' as http;
import 'package:chothuephongtro_v2/models/users/taikhoan.dart';
import 'package:chothuephongtro_v2/utils/uribuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ValueNotifier<int> _selectedRole = ValueNotifier<int>(0);

  void _moveToLoginPage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }
  Future<bool> _sendRegisterRequest(RegisterNode account) async {
    try {
      final response = await http.post(
          UriBuilder.buildApiUri('/accounts/register'),
          headers: {'Content-Type': 'application/json'},
          body: account.toJson()
      );
      if(response.statusCode == 201) {
        print('[register.dart] Registered successfully!');
        ScaffoldMessenger.of(context).
          showSnackBar(
              const SnackBar(
                  content: Text('Đăng ký thành công!')
              )
          );

        Navigator.of(context).pushReplacementNamed('/login');

        return true;
      }
      else if(response.statusCode == 409) {
        print('[register.dart] Conflicted account!');
        ScaffoldMessenger.of(context).
          showSnackBar(
              const SnackBar(
                  content: Text('Tài khoản đã tồn tại!')
              )
          );
      }
      else {
        print('[register.dart] Failed to process register request in the server');
      }
    }
    catch(ex) {
      print('[register.dart] Unable to send register request');
    }
    ScaffoldMessenger.of(context).
      showSnackBar(
          const SnackBar(
              content: Text('Lỗi đăng ký tài khoản!')
          )
      );

    return false;
  }
  void _handleRegister() {
    try {
      if(_passwordController.text != _confirmPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).
          showSnackBar(
            SnackBar(
                content: Text('Mật khẩu không trùng khớp')
            )
          );
      }
      else {
        // Bundle account object
        RegisterNode account = new RegisterNode(
            _accountController.text.trim(),
            _emailController.text.trim(),
            _phoneNumberController.text.trim(),
            _passwordController.text,
            _selectedRole.value
        );
        // Prepare HTTP request [POST]
        FutureBuilder<bool>(
          future: _sendRegisterRequest(account),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data!) {
                ScaffoldMessenger.of(context).
                  showSnackBar(
                      const SnackBar(
                          content: Text('Đăng ký thành công!')
                      )
                  );

                Navigator.of(context).pushReplacementNamed('/login');
              }
              else {
                ScaffoldMessenger.of(context).
                  showSnackBar(
                     const SnackBar(
                          content: Text('Đăng ký thất bại!')
                      )
                  );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        );
      }
    }
    catch(ex) {
      print('[register.dart] Unable to process register data');
      print(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Vui lòng nhập các thông tin bên dưới',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _accountController,
                  decoration: const InputDecoration(
                    labelText: 'Tên đăng nhập',
                    labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                      // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                      // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nhập lại mật khẩu',
                    labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                      // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                      // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                      // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 14,),
                    Text(
                      'Bạn muốn trở thành',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: _selectedRole,
                      builder: (context, selectedRole, child) {
                        return Row(
                          children: [
                            Radio<int>(
                              value: 0,
                              groupValue: selectedRole,
                              onChanged: (value) {
                                _selectedRole.value = value!;
                              },
                            ),
                            const Text(
                              'Khách hàng',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: selectedRole,
                              onChanged: (value) {
                                _selectedRole.value = value!;
                              },
                            ),
                            const Text(
                              'Chủ trọ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                    width: 100,
                    height: 20
                ), // Add some space between the TextFormField and the button
                ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Border radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15
                    ), // Button padding
                  ),
                  child: const Text(
                    'Đăng ký tài khoản',
                    style: TextStyle(
                        color: Colors.white
                    ), // Text color
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the children horizontally
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center the children vertically
                    children: [
                      const Text(
                        'Đã có tài khoản? ',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: _moveToLoginPage,
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
