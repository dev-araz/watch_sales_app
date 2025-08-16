import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:watch_sales_app/models/constants.dart";
import "package:watch_sales_app/views/ui/favorites.dart";
import 'app_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.id,
    required this.height,
  });

  final String name;
  final String image;
  final String price;
  final String category;
  final String id;
  final double height;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;
  final _favBox = Hive.box('fav_box');

  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id'].toString()).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFav = ids.contains(widget.id.toString());

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0.h, 20.w, 0.h),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: widget.height,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: widget.height * 0.6,
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
                      onTap: () async {
                        if (isFav) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        } else {
                          _createFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price": widget.price,
                            "imageUrl": widget.image
                          });
                        }
                      },
                      child: isFav
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_outline_sharp),
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
                          labelPadding: const EdgeInsets.fromLTRB(1, 0, 3, 0),
                          label: const Text(''),
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
