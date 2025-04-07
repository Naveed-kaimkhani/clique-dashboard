
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/data/model/group_model.dart';
import 'package:post_krakren_dashboard/data/repositories/group_repository.dart';


class DiscoverViewModel extends GetxController {
  final userController = Get.find<UserController>();
  
//  final userController =    Get.put(UserController());
  final groupRepository = Get.find<GroupRepository>();
  final RxList<Group> groups = <Group>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var userJoinedGroups = <String>[].obs; // List of groups user has joined


 
  @override
  void onInit() {
    super.onInit();
    // fetchPopstreams();
    fetchGroups();
  }

//     Future<void> fetchPopstreams() async {
//        final String lamdaToken = userController.revoLamdaToken.value; // Securely store this
//  final String authToken = userController.revoAccessToken.value; // Securely store this
//     log("auth token");
//     log(authToken);
//     try {
//       final response = await GetConnect().post(
//         apiUrl,
//         {
//           "last_id": "",
//           "brand_name": "clique",
//           "email": "",
//           "search_text": "",
//           "size": 12,
//           "lambda_token": "$lamdaToken"
//         },
//         headers: {
//           "Authorization": "Bearer $authToken",
//           "Content-Type": "application/json",
//         },
//       );
//       log(response.body.toString());
//       log(response.statusCode.toString());
//       if (response.statusCode == 200) {
//         List<dynamic> popstreamList = response.body['popstreams'];
//         popstreams.value = popstreamList.map((item) => PopstreamModel.fromJson(item)).toList();
//       } else {
//         Get.snackbar("Error", "Failed to fetch Popstreams");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     }
//   }


// Future<void> fetchPopstreams() async {
//   final prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences
//   final String lamdaToken =userController.revoLamdaToken.value; // Retrieve lambda token
//   String authToken = userController.revoAccessToken.value; // Retrieve access token

//   // Check if the token is expired
//   final int? tokenExpiration = prefs.getInt('tokenExpiration'); // Retrieve expiration time
//   final bool isTokenExpired = tokenExpiration == null || DateTime.now().millisecondsSinceEpoch > tokenExpiration;

//   if (isTokenExpired) {
//     try {
//       // Refresh the token
//       final refreshResponse = await GetConnect().post(
//         'https://clique.revovideo.net/api/auth/token',
//         {
//           "email": userController.userEmail.value// Retrieve email from SharedPreferences
//         },
//       );

//       if (refreshResponse.statusCode == 200) {
//         authToken = refreshResponse.body['access_token']; // Assuming the response contains the new token
//         final int expiresIn = refreshResponse.body['expires_in']; // Assuming the response contains the expiration time in seconds
//         final int newExpirationTime = DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000);

//         // Update the token and expiration time in SharedPreferences
//         await prefs.setString('revo_access_token', authToken);
//         await prefs.setInt('tokenExpiration', newExpirationTime);

//         // Update the token in the userController (if needed)
//         userController.revoAccessToken.value = authToken;
//       } else {
//         Get.snackbar("Error", "Failed to refresh token");
//         return;
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred while refreshing token: $e");
//       return;
//     }
//   }

//   log("auth token");
//   log(authToken);

//   try {
//     final response = await GetConnect().post(
//       apiUrl,
//       {
//         "last_id": "",
//         "brand_name": "clique",
//         "email": "",
//         "search_text": "",
//         "size": 12,
//         "lambda_token": lamdaToken,
//       },
//       headers: {
//         "Authorization": "Bearer $authToken",
//         "Content-Type": "application/json",
//       },
//     );

//     log(response.body.toString());
//     log(response.statusCode.toString());

//     if (response.statusCode == 200) {
//       List<dynamic> popstreamList = response.body['popstreams'];
//       popstreams.value = popstreamList.map((item) => PopstreamModel.fromJson(item)).toList();
//     } else {
//       Get.snackbar("Error", "Failed to fetch Popstreams");
//     }
//   } catch (e) {
//     Get.snackbar("Error", "An error occurred: $e");
//   }
// }
  Future<void> fetchGroups() async {
    isLoading.value = true;
    try {
      final fetchedGroups = await groupRepository.fetchGroups();
      groups.value = fetchedGroups;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}