import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:watch_sales_app/views/ui/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // صبر می‌کنیم تا انیمیشن تموم بشه
    Future.delayed(const Duration(milliseconds: 2530), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RiveAnimation.asset(
          'assets/rive/splash.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
