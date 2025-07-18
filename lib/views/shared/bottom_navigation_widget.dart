import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ionicons/ionicons.dart';

class bottomNavigationIcons extends StatelessWidget {
  const bottomNavigationIcons({super.key, this.onTap, this.icon});
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36.h,
        width: 36.w,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
