
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class ProductRepository {
  final String baseUrl = 'https://dev.moutfits.com/api/v1/topdawg/products';

  final userController = Get.find<UserController>();
Future<List<ProductModel>> fetchProducts({
  int page = 1,
  int perPage = 100,
}) async {
  final response = await http.get(
    Uri.parse('$baseUrl?page=$page&per_page=$perPage'),
    headers: {
      'Authorization': 'Bearer ${userController.token.value}',
      'Accept': 'application/json',
    },
  );

  // log(response.body.toString());

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> productsJson = data['products'];
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
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