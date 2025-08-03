import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:watch_sales_app/models/welcome_model.dart';
import 'package:watch_sales_app/views/shared/show_more_list.dart';

class LatestViewsWidget extends StatelessWidget {
  const LatestViewsWidget({
    super.key,
    required Future<List<Welcome>> classicWatches,
  }) : _classicWatches = classicWatches;

  final Future<List<Welcome>> _classicWatches;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<List<Welcome>>(
        future: _classicWatches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final classic = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(left: 9, right: 9),
              child: MasonryGridView.count(
                shrinkWrap: false,
                physics: const ClampingScrollPhysics(),
                cacheExtent: 1000,
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                itemCount: classic!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  double tileHeight = (index % 4 == 1 || index % 4 == 3)
                      ? screenHeight * 0.1
                      : screenHeight * 0.069;
                  final watch = snapshot.data![index];
                  return ShowMoreList(
                      name: watch.name,
                      image: watch.imageUrl[0],
                      price: watch.price,
                      height: tileHeight);
                },
              ),
            );
          }
        });
  }
}
