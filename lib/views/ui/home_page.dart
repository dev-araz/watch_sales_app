import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../shared/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                // padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.33,
                width: double.infinity,
                child: RiveAnimation.asset(
                  "assets/rive/appBar.riv",
                  fit: BoxFit.fill,
                ),
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage("assets/images/appbar.png"),
                //         fit: BoxFit.cover)),
              )
            ],
          ),
        ));
  }
}
