import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'splash.dart';
import 'package:chothuephongtro_v2/login.dart';

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
        '/login': (context) => const LoginPage()
      },
    );
  }
}
