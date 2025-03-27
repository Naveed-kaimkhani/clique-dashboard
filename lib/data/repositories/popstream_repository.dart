// repositories/popstream_repository.dart
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/data/model/popstream_request%20.dart';
import 'dart:convert';

class PopstreamRepository {
  final String baseUrl = 'https://dev.moutfits.com/api/v1';

  Future<List<PopstreamRequest>> fetchRequests() async {
    final response = await http.get(
      Uri.parse('$baseUrl/popstream/requests'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 325|XGd4gdeqZIeoMxppuqJfAwzE0zFyuIePsZGCIZk3d80b1941',
     
        // 'Authorization': 'Bearer $token',
      },
    );
      log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PopstreamRequest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load requests');
    }
  }

  Future<void> approveRequest(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/popstream/approve/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 325|XGd4gdeqZIeoMxppuqJfAwzE0zFyuIePsZGCIZk3d80b1941',
      },
    );
  log(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to approve request');
    }else{
      print('Request approved successfully');
    }
  }

  Future<void> rejectRequest(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/popstream/reject/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer 325|XGd4gdeqZIeoMxppuqJfAwzE0zFyuIePsZGCIZk3d80b1941',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reject request');
    }else{
      print('Request rejected successfully');
    }
  }
}