import 'package:flutter/material.dart';
import '../shared/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Cart Screen',
          style: myFontStyle(24.sp, Colors.black, FontWeight.w700),
        ),
      ),
    );
  }
}
