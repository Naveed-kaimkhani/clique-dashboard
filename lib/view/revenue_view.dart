// views/revenue_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/view_model/revenue_controller.dart';

class RevenueView extends StatelessWidget {
  final controller = Get.put(RevenueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revenue Summary')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error.value}'));
        } else if (controller.revenueData.value == null) {
          return const Center(child: Text('No data available'));
        }

        final data = controller.revenueData.value!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Total Revenue: \$${data.totalRevenue.toStringAsFixed(2)}"),
              subtitle: Text("Total Profit: \$${data.totalProfit.toStringAsFixed(2)}"),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: data.orders.length,
                itemBuilder: (_, index) {
                  final order = data.orders[index];
                  return ListTile(
                    title: Text("Order ID: ${order.orderId}"),
                    subtitle: Text("Customer: ${order.customerId}"),
                    trailing: Text("\$${order.totalPrice}"),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
