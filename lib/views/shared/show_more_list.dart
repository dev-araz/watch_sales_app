import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';

class ShowMoreList extends StatefulWidget {
  const ShowMoreList(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.height});
  final String image;
  final String name;
  final String price;
  final double height;

  @override
  State<ShowMoreList> createState() => _ShowMoreListState();
}

class _ShowMoreListState extends State<ShowMoreList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.image, fit: BoxFit.fill),
            Container(
              padding: EdgeInsets.only(top: 12.h),
              height: widget.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.name,
                        style: myFontStyle(20, Colors.black, FontWeight.w700)),
                    Text(widget.price,
                        style: myFontStyle(12, Colors.black, FontWeight.w400)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
