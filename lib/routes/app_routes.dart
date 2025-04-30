import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/view/auth/otp_screen.dart';
import 'package:post_krakren_dashboard/view/chat_screens/create_group_screen.dart';
import 'package:post_krakren_dashboard/view/dashboard_home/orders_table_screen.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';
import 'package:post_krakren_dashboard/view/products_screen/product_search.dart';
import 'package:post_krakren_dashboard/view/splash_screen.dart';

class AppRoutes {
  static getAppRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.cupertino),

        // GetPage(
        //     name: RouteName.ordersTableScreen,
        //     page: () => const OrdersTableScreen(),
        //     transition: Transition.cupertino),

            
        GetPage(
            name: RouteName.dashboardScreen,
            page: () => const DashboardScreen(),
            transition: Transition.cupertino),
            

        GetPage(
            name: RouteName.oTPScreen,
            page: () =>  OtpScreen(),
            transition: Transition.cupertino),
            

        GetPage(
            name: RouteName.createGroupPage,
            page: () =>  CreateGroupPage(),
            transition: Transition.cupertino),

        GetPage(
            name: RouteName.productSearchScreen,
            page: () =>  ProductSearchScreen(),
            transition: Transition.cupertino),
      
      ];
}