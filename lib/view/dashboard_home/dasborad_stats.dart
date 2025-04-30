import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/stat_card.dart';
import 'package:post_krakren_dashboard/view/dashboard_home/orders_table_screen.dart';
import 'package:post_krakren_dashboard/view_model/revenue_controller.dart';

class DashboardStats extends StatelessWidget {
  DashboardStats({super.key});
  final revenueController = Get.isRegistered<RevenueController>()
      ? Get.find<RevenueController>()
      : Get.put(RevenueController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1000;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobile) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildCards(context).map((card) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: card,
                  ),
                );
              }).toList(),
            ),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: _buildCards(context).sublist(0, 2).map((card) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: card,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: _buildCards(context).sublist(2).map((card) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: card,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return Row(
            children: _buildCards(context).map((card) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: card,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  List<StatCard> _buildCards(BuildContext context) {
    final ordersCount = revenueController.revenueData.value?.orders.length ?? 0;
    final revenueCount = revenueController.revenueData.value?.totalRevenue ?? 0;

    return [
      StatCard(
        title: "Total Revenue",
        value: "\$$revenueCount",
        percentage: "",
        icon: Icons.email,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      ),
      StatCard(
        title: "Total Orders",
        value: ordersCount.toString(),
        percentage: "",
        icon: Icons.shopping_cart,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrdersTableScreen(
                orders: revenueController.revenueData.value!.orders),
          ),
        ),
      ),
      // StatCard(
      //   title: "Conversion",
      //   value: "86.6%",
      //   icon: Icons.filter_alt,
      //   showProgress: true,
      // ),
      // StatCard(
      //   title: "AVG Orders",
      //   value: "\$80",
      //   icon: Icons.analytics,
      // ),
    ];
  }
}
