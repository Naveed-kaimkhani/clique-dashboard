
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/data/model/influencer_model.dart';
import 'package:post_krakren_dashboard/data/repositories/influencer_repository.dart';
import 'package:http/http.dart' as http;
class InfluencerViewmodel extends GetxController {
  final InfluencerRepository _userRepository = InfluencerRepository();
  var influencers = <InfluencerModel>[].obs;
  var isLoading = true.obs; // Add this line
  final UserController userController = Get.find<UserController>();
  var error = ''.obs; // Add this line to handle errors

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }
Future<void> deleteUser(int uid) async {
  try {
    isLoading.value = true;
    final response = await http.delete(
      Uri.parse('https://cactisocial.com/api-clique/public/api/v1/user/delete/$uid'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userController.token.value}', // Use your token variable
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['message'] == 'User deleted successfully') {
        influencers.removeWhere((user) => user.id == uid);
        Get.snackbar('Success', 'User deleted successfully');
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Something went wrong');
      }
    } else {
      Get.snackbar('Error', 'Failed to delete user');
    }
  } catch (e) {
    Get.snackbar('Error', 'An error occurred: $e');
  } finally {
    isLoading.value = false;
  }
}
Future<void> updateUserRole(int uid, String newRole) async {
  log(userController.token.value);

  try {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse('https://cactisocial.com/api-clique/public/api/v1/user/update-role'), // ✅ Updated path
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${userController.token.value}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': uid,
        'role': newRole,
      }),
    );
    log("role updateeee");
log(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar('Success', responseData['message'] ?? 'Role updated');

      // Update the local list
      final index = influencers.indexWhere((user) => user.id == uid);
      if (index != -1) {
        influencers[index].role = newRole;
        influencers.refresh(); // Trigger UI update
      }
    } else {

      Get.snackbar('Error', 'Failed to update role');
    }
  } catch (e) {
    log(e.toString());
    Get.snackbar('Error', 'An error occurred: $e');
  } finally {
    isLoading.value = false;
  }
}


  void fetchUsers() async {
    try {
      isLoading(true); // Set loading to true before fetching data
      var fetchedUsers = await _userRepository.fetchInfluencers();
      influencers.assignAll(fetchedUsers);
    } catch (e) {
      error(e.toString()); // Set the error message if something goes wrong
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false); // Set loading to false after fetching data (whether successful or not)
    }
  }
}