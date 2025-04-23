
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';

class ProductRepository {
  final String baseUrl = 'https://cactisocial.com/api-clique/public/api/v1/topdawg/products';

  final userController = Get.find<UserController>();

  Future<Map<String, dynamic>> fetchProducts({
    int page = 1,
    int perPage = 10,
  }) async {
    final response = await http.get(
      Uri.parse('https://cactisocial.com/api-clique/public/api/v1/topdawg/products?page=$page'),
      headers: {
        'Authorization': 'Bearer ${userController.token.value}',
        'Accept': 'application/json',
      },
    
    );
// log(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data; // Return the full response to include pagination info
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<bool> updatePricePercentage(double percentage) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}/settings/price-percentage');

    final response = await http.post(
      url,
      headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userController.token.value}',
      },
      body: jsonEncode({'percentage': percentage}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update price: ${response.body}');
      return false;
    }
  }
}