import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'app_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.id,
    required this.height, // ✅ اضافه شده
  });

  final String name;
  final String image;
  final String price;
  final String category;
  final String id;
  final double height; // ✅ اضافه شده

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0.h, 20.w, 0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: widget.height, // ✅ استفاده از ارتفاع داده‌شده
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: widget.height * 0.6, // 🎯 تنظیم ارتفاع نسبی تصویر
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 10.h,
                    child: GestureDetector(
                      onTap: null,
                      child: Icon(Icons.favorite_outline_sharp),
                    ),
                  )
                ],
              ),
              SizedBox(height: 9.h),
              Padding(
                padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: myFontStyle(33, Colors.black, FontWeight.w800)),
                    Text(widget.category,
                        style: myFontStyle(19, Colors.grey, FontWeight.w400)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.price,
                        style: myFontStyle(15, Colors.black, FontWeight.w800)),
                    Row(
                      children: [
                        Text('رنگ‌ها',
                            style:
                                myFontStyle(14, Colors.grey, FontWeight.w300)),
                        SizedBox(width: 5.w),
                        ChoiceChip(
                          labelPadding: EdgeInsets.fromLTRB(1, 0, 3, 0),
                          label: Text(''),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
