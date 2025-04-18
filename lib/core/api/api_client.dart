import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class ApiClient extends GetxService {
  
  final UserController userController = Get.put(UserController());
  final String baseUrl = ApiEndpoints.baseUrl;
   Future<http.Response> post({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse(url),headers: headers, body: body);
  }

//    Future<http.Response> verifyOtp({
//     required String url,
//     // Map<String, String>? headers,
//     Object? body,
//   }) async {
//     return await http.post(Uri.parse('https://dev.moutfits.com/api/v1/otp/verify'),
//      body: jsonEncode({
//   "phone": "3103443527",
//   "otp": "123456"
//  }),
// );
//   }

   Future<http.Response> verifyOtp({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse('https://dev.moutfits.com/api/v1/otp/verify'),
     body: body,
     headers: headers,
);
  }

   Future<http.Response> login({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse('https://dev.moutfits.com/api/v1/login'),
     body: body,
     headers: headers,
);
  }
   Future<http.Response> sendOtp({
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    return await http.post(Uri.parse("https://dev.moutfits.com/api/v1/otp/send"),
     body: body,
     headers: headers,
);
  }

Future<dynamic> getGroup(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(endpoint), headers: headers);

    return response;
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(Uri.parse(endpoint), headers: headers);
    return _handleResponse(response);
  }
  static Future<http.Response> getMessages({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

//  Future<http.Response> getInfluencersApi({
//   required String url,
//   Map<String, String>? params, // Add params instead of headers
//    Map<String, String>? headers,
// }) async {
//   // Create a URI with query parameters
//   Uri uri = Uri.parse(url,headers: headers).replace(queryParameters: params);

//   // Make the GET request
//   return await http.get(uri);
// }
Future<http.Response> getInfluencersApi({
  required String url,
  Map<String, String>? params,
  String? authToken, // Make authToken nullable
}) async {
  Uri uri = Uri.parse(url);

  Map<String, String> headers = {
    "Content-Type": "application/json", // Always include this header
  };

  // Add auth token to headers if provided
  if (authToken != null) {
    headers["Authorization"] = "Bearer $authToken";
  }

  return await http.get(uri, headers: headers);
}

  static Future<http.Response> fetchMessages({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<dynamic> loginUser(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData["token"];
      final String userName = responseData["user"]["name"];
      final int userId = responseData["user"]["id"];
      
      final String role = responseData["user"]["role"];
          final String? profileImage = responseData["user"]["profile_photo_url"];          
          final String? coverPhotoUrl = responseData["user"]["cover_photo_url"];       
          final String email = responseData["user"]["email"];
     final String phone = responseData["user"]["phone"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userName', userName);
      await prefs.setString('role', role);
      await prefs.setInt('uid', userId);
      await prefs.setString('profile_photo_url', profileImage ?? '');
      await prefs.setString('cover_photo_url', coverPhotoUrl ?? '');
      await prefs.setString('email', email);
       await prefs.setString('phone', phone);
    
    final storedToken = prefs.getString('token');
    log("token fetchedddd$storedToken");
    // await  UserController().loadUserSession();
      await  userController.loadUserSession();
  //     final UserController userController = Get.put(UserController());

  // final DiscoverViewModel _viewModel = Get.put(DiscoverViewModel());
 Get.toNamed(RouteName.homeScreen,);
  // Get.to(()=> HomeScreen(), transition: Transition.zoom);
      
//       Get.put(UserController());
//  Get.put(DiscoverViewModel());
      return responseData;
    }
    return _handleResponse(response);
  }

  // Future<dynamic> post(String endpoint,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   final response = await http.post(Uri.parse(endpoint),
  //       headers: headers, body: jsonEncode(body));
 
  //   return _handleResponse(response);
  // }
    Future<void> signUpApi(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: jsonEncode(body));
                 if (response.statusCode == 201 || response.statusCode==200) {
                        Get.offAllNamed(RouteName.loginScreen);               
    }
    return _handleResponse(response);
  }


    Future<dynamic> joinGroupApi(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: jsonEncode(body));
    return _handleResponse(response);
  }
  //  Future<dynamic> fetchGroupMembersApi(String endpoint,
  //     {Map<String, String>? headers, dynamic body}) async {
  //   final response = await http.post(Uri.parse(endpoint),
  //       headers: headers, body: jsonEncode(body));
  //   return _handleResponse(response);
  // }
  Future<dynamic> put(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(Uri.parse('$baseUrl$endpoint'),
        headers: headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint,
      {Map<String, String>? headers}) async {
    final response =
        await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) async {
  
    switch (response.statusCode) {
      case 200:
      
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 400:
      case 401:
      case 403:
      case 422:
      case 404:
      case 500:
      
        Utils.showCustomSnackBar("Error", Utils.mapErrorMessage(response.body),ContentType.failure );
        // throw Exception('Error: ${response.body},');
      default:
      
        Utils.showCustomSnackBar("Error", Utils.mapErrorMessage(response.body),ContentType.failure );
        // throw Exception('Unexpected error occurred');
    }
  }
}
