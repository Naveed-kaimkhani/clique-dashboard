import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/view/auth/otp_screen.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';
import 'package:post_krakren_dashboard/view/splash_screen.dart';

class AppRoutes {
  static getAppRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.cupertino),

            
        GetPage(
            name: RouteName.dashboardScreen,
            page: () => const DashboardScreen(),
            transition: Transition.cupertino),
            

        GetPage(
            name: RouteName.oTPScreen,
            page: () =>  OtpScreen(),
            transition: Transition.cupertino),
      
      ];
}