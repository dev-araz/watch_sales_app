import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:watch_sales_app/models/welcome_model.dart';
import 'package:watch_sales_app/services/helper.dart';
import 'package:watch_sales_app/views/shared/HomeTabBarViewWidget.dart';
import 'package:watch_sales_app/views/shared/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

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
    getClassicWatches();
    getWomenWatches();
    getSportWatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 39.h, right: 20.w),
                  child: Text('فروشـگاه سـاعت',
                      style: myFontStyle(33, Colors.white, FontWeight.w800)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.h, right: 20.w),
                  child: Text('مجموعه‌ی بی‌نظیر از بهترین‌ها',
                      style: myFontStyle(17.9, Colors.white, FontWeight.w400)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h, right: 0.w),
                  child: TabBar(
                    tabs: const [
                      Tab(text: 'کلاسیک'),
                      Tab(text: 'زنانه'),
                      Tab(text: 'هوشمند'),
                    ],
                    controller: tabController,
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
                  child: Container(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // First Tab
                        HomeTabBarViewWidget(
                          classicWatches: _classicWatches,
                          tabIndex: 0,
                        ),
                        // Second Tab
                        HomeTabBarViewWidget(
                          classicWatches: _womenWatches,
                          tabIndex: 1,
                        ),
                        // Third Tab
                        HomeTabBarViewWidget(
                          classicWatches: _sportWatches,
                          tabIndex: 2,
                        ),
                      ],
                    ),
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
