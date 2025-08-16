import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rive/rive.dart' as rive;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:watch_sales_app/models/constants.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:watch_sales_app/views/ui/mainscreen.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _favBox = Hive.box('fav_box');
  _deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item["category"],
        "price": item["price"],
        "imageUrl": item["imageUrl"],
        "name": item["name"],
      };
    }).toList();
    fav = favData.reversed.toList();
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            // padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: rive.RiveAnimation.asset(
              "assets/rive/appBar.riv",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 39.h, right: 9.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      'لیست علاقه‌مندی ها',
                      style: myFontStyle(19, Colors.white, FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 9.h,
                ),
                Divider(
                  color: Colors.grey,
                  endIndent: 6.w,
                  height: 6.h,
                  indent: 6.w,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: fav.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width,
                          child: rive.RiveAnimation.asset(
                            "assets/rive/list_empty.riv",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: fav.length,
                    padding: EdgeInsets.only(top: 79.h),
                    itemBuilder: (BuildContext context, int index) {
                      final watch = fav[index];
                      return Padding(
                        padding: EdgeInsets.all(8.r),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(13.r),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.3,
                                  color: Colors.grey.shade500,
                                  spreadRadius: 6,
                                  offset: Offset(0, 1))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(13.r),
                                      child: Image.asset(
                                        watch['imageUrl'],
                                        height: 69.h,
                                        width: 69.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 13.h, left: 19.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            watch["name"],
                                            style: myFontStyle(16, Colors.black,
                                                FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            watch["category"],
                                            style: myFontStyle(
                                                13,
                                                Colors.black54,
                                                FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            watch["price"],
                                            style: myFontStyle(16, Colors.black,
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(9.r),
                                  child: GestureDetector(
                                    onTap: () {
                                      _deleteFav(watch["key"]);
                                      ids.removeWhere(
                                          (element) => element == watch['id']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreen()));
                                    },
                                    child: const Icon(Ionicons.heart_dislike),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )
        ],
      ),
    ));
  }
}
