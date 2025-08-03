import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';

class Category extends StatefulWidget {
  const Category(
      {super.key,
      this.onPressed,
      required this.label,
      required this.buttonColor});
  final void Function()? onPressed;
  final String label;
  final Color buttonColor;
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: widget.onPressed,
        child: Container(
          height: 33.h,
          width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.buttonColor,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: myFontStyle(13.sp, widget.buttonColor, FontWeight.w600),
            ),
          ),
        ));
  }
}
