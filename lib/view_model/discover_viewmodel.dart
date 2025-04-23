import 'package:get/get.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/data/model/group_model.dart';
import 'package:post_krakren_dashboard/data/repositories/group_repository.dart';

class DiscoverViewModel extends GetxController {
  final userController = Get.find<UserController>();
  final groupRepository = Get.find<GroupRepository>();
  final RxList<Group> groups = <Group>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  var userJoinedGroups = <String>[].obs; // List of groups user has joined


 
  @override
  void onInit() {
    super.onInit();
    fetchGroups();
  }

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