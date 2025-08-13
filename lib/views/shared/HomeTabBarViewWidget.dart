import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:watch_sales_app/controllers/main_screen_provider.dart';
import 'package:watch_sales_app/models/welcome_model.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:watch_sales_app/views/shared/latestWatches.dart';
import 'package:watch_sales_app/views/shared/product_card.dart';
import 'package:watch_sales_app/views/ui/product_page.dart';
import 'package:watch_sales_app/views/ui/show_more_page.dart';
// import 'package:watch_sales_app/views/ui/show_more_page.dart';

class HomeTabBarViewWidget extends StatelessWidget {
  const HomeTabBarViewWidget({
    super.key,
    required Future<List<Welcome>> classicWatches,
    required this.tabIndex,
  }) : _classicWatches = classicWatches;

  final Future<List<Welcome>> _classicWatches;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: FutureBuilder<List<Welcome>>(
                future: _classicWatches,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else {
                    final classic = snapshot.data;
                    return ListView.builder(
                      itemCount: classic!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final watch = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        id: watch.id,
                                        category: watch.category)));
                          },
                          child: ProductCard(
                              height: MediaQuery.of(context).size.height * 0.4,
                              name: watch.name,
                              image: watch.imageUrl[0],
                              price: watch.price,
                              category: watch.category,
                              id: watch.id),
                        );
                      },
                    );
                  }
                })),
        Padding(
          padding: EdgeInsets.only(
            top: 8.h,
            left: 8.w,
            right: 8.w,
            bottom: 6.h,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowMore(tabIndex: tabIndex)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'آخرین بازدید‌ها',
                  style: myFontStyle(19, Colors.black, FontWeight.w800),
                ),
                TextButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    Provider.of<MainScreenNotifier>(context, listen: false)
                        .setSelectedTab(tabIndex);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowMore(
                                  tabIndex: tabIndex,
                                )));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                  ),
                  label: Text(
                    'موارد بیشتر',
                    style: myFontStyle(16, Colors.black, FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: FutureBuilder<List<Welcome>>(
                future: _classicWatches,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else {
                    final classic = snapshot.data;
                    return ListView.builder(
                      itemCount: classic!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final watch = snapshot.data![index];
                        return LatestWatches(imageUrl: watch.imageUrl[1]);
                      },
                    );
                  }
                })),
      ],
    );
  }
}
