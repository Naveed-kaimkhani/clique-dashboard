import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/view/onboarding_2.dart';
import 'package:post_krakren_dashboard/view/splash_screen.dart';

class AppRoutes {
  static getAppRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.cupertino),
            
        GetPage(
            name: RouteName.onboard2,
            page: () => const OnboardTwo(),
            transition: Transition.cupertino),

      
      ];
}