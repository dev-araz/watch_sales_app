import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:watch_sales_app/controllers/product_provider.dart';
import 'package:watch_sales_app/models/constants.dart';
import 'package:watch_sales_app/models/welcome_model.dart';
import 'package:watch_sales_app/services/helper.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:watch_sales_app/views/shared/checkout_button.dart';
import 'package:watch_sales_app/views/ui/favorites.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');
  final PageController pageController = PageController();
  late Future<Welcome> _watches;

  List<String> brand = [
    "assets/images/brands/5.png",
    "assets/images/brands/4.png",
    "assets/images/brands/1.png",
    "assets/images/brands/3.png",
    "assets/images/brands/0.png",
    "assets/images/brands/2.png",
  ];

  @override
  void initState() {
    super.initState();
    getWatches();
    getFavorites(); // ✅ بارگذاری اولیه علاقه‌مندی‌ها
  }

  void getWatches() {
    if (widget.category == 'کلاسیک') {
      _watches = Helper().getClassicId(widget.id);
    } else if (widget.category == 'زنانه') {
      _watches = Helper().getWomenId(widget.id);
    } else {
      _watches = Helper().getSportId(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
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
        "id": item["id"], // ✅ مقدار واقعی id
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((item) => item['id'].toString()).toList(); // ✅ یکدست‌سازی
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Welcome>(
          future: _watches,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            } else {
              final watches = snapshot.data;
              return Consumer<ProductNotifier>(
                  builder: (context, productNotifier, child) {
                final isFav =
                    ids.contains(watches!.id.toString()); // ✅ بررسی درست

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: const Icon(Ionicons.ellipsis_horizontal),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: double.infinity,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: watches.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (Page) {
                                  productNotifier.activePage = Page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white70,
                                        child: Image.asset(
                                          watches.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        right: 20.w,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isFav) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FavoritesPage(),
                                                ),
                                              );
                                            } else {
                                              _createFav({
                                                "id": watches.id,
                                                "name": watches.name,
                                                "category": watches.category,
                                                "price": watches.price,
                                                "imageUrl": watches.imageUrl[1]
                                              });
                                            }
                                          },
                                          child: Icon(
                                            isFav
                                                ? Ionicons.heart
                                                : Ionicons.heart_outline,
                                            color: Colors.black,
                                            size: 22.sp,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.h,
                                        right: 0.w,
                                        left: 0.w,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            watches.imageUrl.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w),
                                              child: CircleAvatar(
                                                radius: 5.r,
                                                backgroundColor: productNotifier
                                                            .activepage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 270.h,
                              bottom: 1.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.r),
                                  topRight: Radius.circular(0.r),
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.66,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey[300],
                                  child: Padding(
                                    padding: EdgeInsets.all(13.dg),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          watches.name,
                                          style: myFontStyle(23.sp,
                                              Colors.black, FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              watches.category,
                                              style: myFontStyle(14.sp,
                                                  Colors.grey, FontWeight.w400),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22.sp,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 1),
                                              itemBuilder: ((context, _) =>
                                                  Icon(Icons.star,
                                                      size: 18.sp,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              222,
                                                              182,
                                                              1))),
                                              onRatingUpdate: (rating) {},
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              watches.price,
                                              style: myFontStyle(
                                                  16.sp,
                                                  Colors.black,
                                                  FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'رنگ‌ها ',
                                                  style: myFontStyle(
                                                      14.sp,
                                                      Colors.black,
                                                      FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 196, 145, 58),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'سایر برند‌ها',
                                                  style: myFontStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 19.w,
                                                ),
                                                Text(
                                                  'برند‌های موجود در فروشگاه',
                                                  style: myFontStyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            SizedBox(
                                              height: 40.h,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: brand.length,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.all(8.w),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        child: Image.asset(
                                                          brand[index],
                                                          height: 60.h,
                                                          width: 80.w,
                                                          // color: Colors.black,
                                                        ),
                                                      ));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Divider(
                                          indent: 9.w,
                                          endIndent: 9.w,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            watches.title,
                                            style: myFontStyle(19.sp,
                                                Colors.black, FontWeight.w800),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Text(
                                          watches.description,
                                          style: myFontStyle(14.sp,
                                              Colors.black, FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: CheckoutButton(
                                              onTab: () async {
                                                _createCart({
                                                  "id": watches.id,
                                                  "name": watches.name,
                                                  "category": watches.category,
                                                  "price": watches.price,
                                                  "imageUrl":
                                                      watches.imageUrl[1],
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "به سبد خرید اضافه شد ✅",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: myFontStyle(
                                                          13,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: 50.w,
                                                        vertical: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                              label: "اضافه کردن به سبد خرید"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            }
          }),
    );
  }
}
