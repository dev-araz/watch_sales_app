import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:watch_sales_app/controllers/main_screen_provider.dart';
import 'package:watch_sales_app/views/shared/bottom_navigation_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (conext, mainScreenNotifier, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            padding: EdgeInsets.all(8.r),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomNavigationIcons(
                  icon: mainScreenNotifier.pageIndex == 0
                      ? Ionicons.home
                      : Ionicons.home_outline,
                  onTap: () {
                    mainScreenNotifier.pageIndex = 0;
                  },
                ),
                bottomNavigationIcons(
                  icon: mainScreenNotifier.pageIndex == 1
                      ? Ionicons.search
                      : Ionicons.search_outline,
                  onTap: () {
                    mainScreenNotifier.pageIndex = 1;
                  },
                ),
                bottomNavigationIcons(
                  icon: mainScreenNotifier.pageIndex == 2
                      ? MdiIcons.plusCircle
                      : Ionicons.add,
                  onTap: () {
                    mainScreenNotifier.pageIndex = 2;
                  },
                ),
                bottomNavigationIcons(
                  icon: mainScreenNotifier.pageIndex == 3
                      ? Ionicons.cart
                      : Ionicons.cart_outline,
                  onTap: () {
                    mainScreenNotifier.pageIndex = 3;
                  },
                ),
                bottomNavigationIcons(
                  icon: mainScreenNotifier.pageIndex == 4
                      ? Ionicons.person
                      : Ionicons.person_outline,
                  onTap: () {
                    mainScreenNotifier.pageIndex = 4;
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
