// repositories/popstream_repository.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/data/model/popstream_request%20.dart';
import 'dart:convert';

class PopstreamRepository {
  final String baseUrl = 'https://dev.moutfits.com/api/v1';

  final UserController controller = Get.find<UserController>();
  Future<List<PopstreamRequest>> fetchRequests() async {
    final response = await http.get(
      Uri.parse('$baseUrl/popstream/requests'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${controller.token.value}',
     
        // 'Authorization': 'Bearer $token',
      },
    );
    log("Fetching requests from: $baseUrl/popstream/requests");
    log("Response status code: ${response.statusCode}");
      log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PopstreamRequest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load requests');
    }
  }

  Future<void> approveRequest(int id) async {
  try {
    log("Approving request with ID: $id");

    final response = await http.post(
      Uri.parse('$baseUrl/popstream/approve/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${controller.token.value}',
      },
    );
    log(response.toString());
    log("Response body: ${response.body}");
    log("Status code: ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception('Failed to approve request');
    } else {
      log('Request approved successfully');
    }
  } catch (e, stackTrace) {
    log('Error approving request: $e');
    // log('Stack trace: $stackTrace');
    // You can also show a snackbar or toast here if needed
  }
}


  Future<void> rejectRequest(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/popstream/reject/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${controller.token.value}',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject request');
    }else{
      print('Request rejected successfully');
    }
  }
}