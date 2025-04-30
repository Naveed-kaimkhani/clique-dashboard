import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/models/top_dawg_order.dart';

class OrdersRepo {
  final userController = Get.find<UserController>();
  Future<RevenueResponse> fetchRevenueData({
    required String startDate,
    required String endDate,
    int status = 4,
  }) async {
    final url = Uri.parse(
      '${ApiEndpoints.baseUrl}/topdawg/revenue?start_date=$startDate&end_date=$endDate&status=$status',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${userController.token.value}',
        'Content-Type': 'application/json',
      },
    );
    log(response.body);
    if (response.statusCode == 200) {
      return RevenueResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load revenue data: ${response.statusCode}');
    }
  }
}
