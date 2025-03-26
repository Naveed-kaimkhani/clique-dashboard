import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/routes/app_routes.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';
import 'package:post_krakren_dashboard/view/products_screen/product_page.dart';
import 'package:post_krakren_dashboard/view/videos_approval/videos_approval.dart';
void main() {
  runApp(
      //  DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(),
      // ),
      MyApp()
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
        fontFamily: 'ClashDisplay',  // Apply font globally
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'ClashDisplay'),
          bodySmall: TextStyle(fontFamily: 'ClashDisplay'),
        ),
      ),
      home: DashboardScreen(),
      
      // initialRoute: RouteName.onboardScreen,
      
      getPages: AppRoutes.getAppRoutes(),
    );
  }
}

