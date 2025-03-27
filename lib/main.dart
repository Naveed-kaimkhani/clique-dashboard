
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/core/api/api_client.dart';
import 'package:post_krakren_dashboard/data/repositories/auth_repo.dart';
import 'package:post_krakren_dashboard/data/repositories/group_repository.dart';
import 'package:post_krakren_dashboard/data/repositories/influencer_repository.dart';
import 'package:post_krakren_dashboard/routes/app_routes.dart';
import 'package:post_krakren_dashboard/view/auth/login.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';
void main() {
  
   Get.lazyPut(()=>AuthRepository());
   
   Get.put(ApiClient());

   Get.lazyPut(()=>GroupRepository());
  //  Get.lazyPut(()=>AuthRepository());
   
   Get.lazyPut(()=>InfluencerRepository());
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
      home: DashboardScreen(
 
      ),
      
      // initialRoute: RouteName.onboardScreen,
      
      getPages: AppRoutes.getAppRoutes(),
    );
  }
}

