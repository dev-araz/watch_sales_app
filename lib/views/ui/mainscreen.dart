import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:watch_sales_app/controllers/main_screen_provider.dart';
import 'package:watch_sales_app/views/shared/bottom_nav_bar.dart';
import 'package:watch_sales_app/views/ui/cart_page.dart';
import 'package:watch_sales_app/views/ui/home_page.dart';
import 'package:watch_sales_app/views/ui/profile.dart';
import 'package:watch_sales_app/views/ui/search_page.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    HomeScreen(),
    SearchScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar());
    });
  }
}
