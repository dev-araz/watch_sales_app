import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
// import 'package:watch_sales_app/views/ui/mainscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:watch_sales_app/controllers/increament_decreament_provider.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:watch_sales_app/views/shared/checkout_button.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: _cartBox.listenable(),
            builder: (context, Box box, _) {
              List<dynamic> cart = [];
              final cartData = _cartBox.keys.map((key) {
                final item = _cartBox.get(key);

                return {
                  "key": key,
                  "id": item['id'],
                  "category": item['category'],
                  "name": item['name'],
                  "imageUrl": item['imageUrl'],
                  "price": item['price'],
                };
              }).toList();

              cart = cartData.reversed.toList();
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                    child: rive.RiveAnimation.asset(
                      "assets/rive/appBar.riv",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 39.h, right: 9.w),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 9.w,
                                ),
                                Text(
                                  'سبد خرید',
                                  style: myFontStyle(
                                      19, Colors.white, FontWeight.w600),
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
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: cart.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.33,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: rive.RiveAnimation.asset(
                                              "assets/rive/list_empty.riv",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: cart.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        final data = cart[index];
                                        return Padding(
                                          padding: EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13.r)),
                                            child: Slidable(
                                              key: const ValueKey(0),
                                              endActionPane: ActionPane(
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    SlidableAction(
                                                        flex: 1,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF000000),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        label: "حذف",
                                                        onPressed: null)
                                                  ]),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.13,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade500,
                                                        spreadRadius: 6,
                                                        blurRadius: 0.3,
                                                        offset: Offset(0, 1))
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: 60.h,
                                                              ),
                                                              child: Container(
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(13
                                                                              .r))),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await _cartBox
                                                                          .delete(
                                                                              data['key']);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  )),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          13.r),
                                                              child:
                                                                  Image.asset(
                                                                data[
                                                                    'imageUrl'],
                                                                height: 60.h,
                                                                width: 60.h,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 13.h,
                                                                  left: 13.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data['name'],
                                                                style: myFontStyle(
                                                                    19,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                data[
                                                                    'category'],
                                                                style: myFontStyle(
                                                                    13,
                                                                    Colors
                                                                        .black54,
                                                                    FontWeight
                                                                        .w400),
                                                              ),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                data['price'],
                                                                style: myFontStyle(
                                                                    16,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: Container(
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                              IncrementDecrementProvider>()
                                                                          .decrement();
                                                                    },
                                                                    child: const Icon(
                                                                        Ionicons
                                                                            .remove,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .black87),
                                                                  ),
                                                                  Consumer<
                                                                      IncrementDecrementProvider>(
                                                                    builder: (context,
                                                                        provider,
                                                                        child) {
                                                                      return Text(
                                                                        provider
                                                                            .count
                                                                            .toString(),
                                                                        style:
                                                                            myFontStyle(
                                                                          13,
                                                                          Colors
                                                                              .black,
                                                                          FontWeight
                                                                              .w600,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      context
                                                                          .read<
                                                                              IncrementDecrementProvider>()
                                                                          .increment();
                                                                    },
                                                                    child: const Icon(
                                                                        Ionicons
                                                                            .add,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .black87),
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(
                      label: 'تکمیل خرید',
                      onTab: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "در حال حاظر این قابلیت در دسترس نیست ):",
                              textAlign: TextAlign.center,
                              style: myFontStyle(
                                  13, Colors.black, FontWeight.w600),
                            ),
                            backgroundColor: Colors.white,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.symmetric(
                                horizontal: 50.w,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }));
  }
}
