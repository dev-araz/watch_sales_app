import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:watch_sales_app/controllers/increament_decreament_provider.dart';
import 'package:watch_sales_app/controllers/main_screen_provider.dart';
import 'package:watch_sales_app/controllers/product_provider.dart';
import 'package:watch_sales_app/views/ui/cart.dart';
import 'package:watch_sales_app/views/ui/home_page.dart';
import 'package:watch_sales_app/views/ui/mainscreen.dart';
import 'package:watch_sales_app/views/ui/profile.dart';
import 'package:watch_sales_app/views/ui/search_page.dart';
import 'package:watch_sales_app/views/ui/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => IncrementDecrementProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            routes: {
              '/mainscreen': (context) => MainScreen(),
              '/home': (context) => const HomeScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/cart': (context) => CartPage(),
              '/search': (context) => const SearchScreen(),
            },
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFFE2E2E2),
            ),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            locale: const Locale('fa', 'IR'),
            supportedLocales: const [Locale('fa', 'IR')],
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        });
  }
}
