import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    this.onTab,
    required this.label,
  });
  final void Function()? onTab;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(13.r))),
            height: 39.h,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Center(
              child: Text(
                label,
                style: myFontStyle(16, Colors.white, FontWeight.w600),
              ),
            ),
          )),
    );
  }
}
