import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }
  void moveToLoginPage() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/splash/splash_img.jpg', width: 550.0, height: 470.0),
            const SizedBox(width: 16.0, height: 16.0),
            const Center(
              child: Text(
                'ỨNG DỤNG CHO THUÊ PHÒNG TRỌ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text(
                'DÀNH CHO SINH VIÊN HUFLIT',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 24.0,),
            Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    const Text(
                      """Chúng tôi đảm bảo cung cấp cho sinh viên HUFLIT phòng trọ với giá cả hợp lý, tiện nghi theo giá tiền và an ninh nhất, gần trường nhất có thể.""",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          height: 1.65,
                          color: Color.fromRGBO(81, 81, 81, 100)
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                        onPressed: moveToLoginPage,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: const Color.fromRGBO(85, 101, 255, 100),
                          minimumSize: const Size.fromHeight(32.0), // Thiết lập chiều cao tối thiểu là 32.0
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0), // Bo góc không
                          ),
                        ),
                        child: const Text(
                            'Bắt đầu',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontStyle: FontStyle.normal
                          ),
                        )
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
