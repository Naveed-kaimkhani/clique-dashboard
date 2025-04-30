import 'dart:developer';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/models/Ppopstream_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopstreamController extends GetxController {
  final userController = Get.find<UserController>();

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  RxList<PopstreamModel> popstreams = <PopstreamModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopstreams();
  }

  Future<String?> getValidAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('auth_token');
    String? storedExpiry = prefs.getString('token_expiry');
    bool tokenExpired = true;
    if (storedToken != null && storedExpiry != null) {
      DateTime expiryTime = DateTime.parse(storedExpiry);
      tokenExpired = DateTime.now().isAfter(expiryTime);
    }
    if (storedToken == null || tokenExpired) {
      try {
        final refreshResponse = await GetConnect().post(
          ApiEndpoints.getRevoAccessApi,
          {
            "email": userController.userEmail.value,
          },
        );

        if (refreshResponse.statusCode == 200) {
          storedToken = refreshResponse.body['access_token'];
          final expiresIn = refreshResponse.body['expires_in']; // in seconds
          final expiryTime = DateTime.now().add(Duration(seconds: expiresIn));

          // Save to SharedPreferences
          await prefs.setString('auth_token', storedToken ?? '');
          await prefs.setString('token_expiry', expiryTime.toIso8601String());

          return storedToken;
        } else {
          Get.snackbar("Error", "Failed to refresh token");
          return null;
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred while refreshing token: $e");
        return null;
      }
    } else {
      return storedToken;
    }
  }

  Future<void> deletePopstream(String id) async {
  final String lambdaToken = userController.revoLamdaToken.value;
  final authToken = await getValidAccessToken();
  if (authToken == null) return;

  isLoading.value = true;
  try {
    final response = await GetConnect().post(
      'https://clique.revovideo.net/api/popstream/delete-popstream?language=en',
      {
        "id": id,
        "group_id": "clique",
        "lambda_token": lambdaToken,
      },
      headers: {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200 ) {
      Get.snackbar("Success", "Popstream deleted successfully");
      fetchPopstreams(); // Refresh the list
    } else {
      // Get.snackbar("Error", response.body['message'] ?? "Failed to delete popstream");
    }
  } catch (e) {
    log(e.toString());
    // Get.snackbar("Error", "An error occurred while deleting: $e");
  } finally {
    isLoading.value = false;
  }
}

  Future<void> fetchPopstreams() async {
    final String lamdaToken = userController.revoLamdaToken.value;

    final authToken = await getValidAccessToken();
    if (authToken == null) return;
    log("auth token agya");
    log(authToken);

    log("revo access");
    log(lamdaToken);
    try {
      final response = await GetConnect().post(
        ApiEndpoints.getAllPopstreamUrl,
        {
          "last_id": "",
          "brand_name": "clique",
          "email": "",
          "search_text": "",
          "size": 12,
          "lambda_token": lamdaToken,
        },
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> popstreamList = response.body['popstreams'];
log(popstreamList.toString());
        popstreams.value =
            popstreamList.map((item) => PopstreamModel.fromJson(item)).toList();
        log(popstreams.value.toString());
      } else {
        fetchPopstreams();
        // Get.snackbar("Error", "Failed to fetch popstreams");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
