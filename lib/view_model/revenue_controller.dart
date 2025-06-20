// controllers/revenue_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/repositories/orders_repo.dart';
import 'package:post_krakren_dashboard/models/top_dawg_order.dart';

class RevenueController extends GetxController {
  var isLoading = true.obs;
  var revenueData = Rxn<RevenueResponse>();
  var error = ''.obs;
  final orderRepo = OrdersRepo();
  Future<void> fetchRevenue() async {
    try {
      isLoading.value = true;
      error.value = '';
      final data = await orderRepo.fetchRevenueData(
        startDate: '2025-04-01',
        endDate: '2025-04-29',
      );
      revenueData.value = data;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRevenue();
    super.onInit();
  }
}
