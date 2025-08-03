import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_sales_app/controllers/main_screen_provider.dart';
import 'package:watch_sales_app/models/welcome_model.dart';
import 'package:watch_sales_app/services/helper.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:watch_sales_app/views/shared/category_on_filter_windows.dart';
import 'package:watch_sales_app/views/shared/custom_spacer.dart';
import 'package:watch_sales_app/views/shared/latest_views_widget.dart';

class ShowMore extends StatefulWidget {
  const ShowMore({super.key});

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> with TickerProviderStateMixin {
  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white60,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.83,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.r),
            topRight: Radius.circular(23.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    'فیلترها',
                    style: myFontStyle(26.sp, Colors.black, FontWeight.w800),
                  ),
                  const CustomSpacer(),
                  Text(
                    'استایل',
                    style: myFontStyle(16.sp, Colors.black, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Category(label: "کلاسیک", buttonColor: Colors.black),
                      Category(label: "زنانه", buttonColor: Colors.grey),
                      Category(label: "هوشمند", buttonColor: Colors.grey),
                    ],
                  ),
                  CustomSpacer(),
                  Text(
                    'دسته بندی ها',
                    style: myFontStyle(16.sp, Colors.black, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Category(label: "ساعت مچی", buttonColor: Colors.black),
                      Category(label: "ساعت رومیزی", buttonColor: Colors.grey),
                      Category(label: "ساعت دیواری", buttonColor: Colors.grey),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'محدوده قیمت',
                    style: myFontStyle(16.sp, Colors.black, FontWeight.w400),
                  ),
                  Slider(
                      value: _value,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      max: 1000,
                      divisions: 10,
                      label: _value.round().toString(),
                      secondaryTrackValue: 500,
                      onChanged: (double value) {}),
                  const CustomSpacer(),
                  Text(
                    'برند',
                    style: myFontStyle(16.sp, Colors.black, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 0.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brand.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.r),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // late final TabController tabController =
  //     TabController(length: 3, vsync: this);
  late TabController _tabController;

  late Future<List<Welcome>> _classicWatches;
  late Future<List<Welcome>> _womenWatches;
  late Future<List<Welcome>> _sportWatches;

  void getClassicWatches() {
    _classicWatches = Helper().getClassic();
  }

  void getWomenWatches() {
    _womenWatches = Helper().getWomen();
  }

  void getSportWatches() {
    _sportWatches = Helper().getSport();
  }

  @override
  void initState() {
    super.initState();
    final index = Provider.of<MainScreenNotifier>(context, listen: false)
        .selectedTabIndex;
    _tabController = TabController(length: 3, vsync: this, initialIndex: index);
    getClassicWatches();
    getWomenWatches();
    getSportWatches();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/brands/5.png",
    "assets/images/brands/4.png",
    "assets/images/brands/1.png",
    "assets/images/brands/3.png",
    "assets/images/brands/0.png",
    "assets/images/brands/2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.33,
              width: double.infinity,
              child: rive.RiveAnimation.asset(
                "assets/rive/appBar.riv",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(23.w, 39.h, 23.w, 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          filter();
                        },
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 9.h, right: 0.w, bottom: 16.h),
                  child: TabBar(
                    tabs: const [
                      Tab(text: 'کلاسیک'),
                      Tab(text: 'زنانه'),
                      Tab(text: 'هوشمند'),
                    ],
                    controller: _tabController,
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: myFontStyle(16, Colors.white, FontWeight.w600),
                    unselectedLabelStyle:
                        myFontStyle(16, Colors.white70, FontWeight.w300),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: TabBarView(controller: _tabController, children: [
                      LatestViewsWidget(classicWatches: _classicWatches),
                      LatestViewsWidget(classicWatches: _womenWatches),
                      LatestViewsWidget(classicWatches: _sportWatches),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
