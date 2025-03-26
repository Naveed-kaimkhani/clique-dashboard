import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/view/splash_screen.dart';

class AppRoutes {
  static getAppRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.cupertino),
            

      
      ];
}