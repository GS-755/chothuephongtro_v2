import 'package:chothuephongtro_v2/register.dart';
import 'package:chothuephongtro_v2/users/homepage.dart';
import 'package:flutter/material.dart';
import 'package:chothuephongtro_v2/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'splash.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cho thuê phòng trọ',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/login/register': (context) => const RegisterPage(),
        '/user/index': (context) => const HomePage()
      },
    );
  }
}
