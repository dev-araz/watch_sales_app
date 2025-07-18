import 'package:flutter/material.dart';
import '../shared/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Screen',
          style: myFontStyle(24.sp, Colors.black, FontWeight.w700),
        ),
      ),
    );
  }
}
