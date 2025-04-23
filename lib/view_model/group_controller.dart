import 'dart:async';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/core/api/api_client.dart';
import 'package:post_krakren_dashboard/data/repositories/group_repository.dart';
import 'package:post_krakren_dashboard/view_model/discover_viewmodel.dart';
class GroupController extends GetxController {
  final ApiClient apiClient = Get.find<ApiClient>();
  GroupRepository groupRepository=GroupRepository();
  final DiscoverViewModel _viewModel = Get.find<DiscoverViewModel>();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  

  Future<void> deleteGroupByGuid(String guid) async {
    await groupRepository.deleteGroup(guid);
       _viewModel.groups.removeWhere((g) => g.guid == guid); // remove from list

  }
Future<void> renameGroup(String guid, String newName) async {
  final success = await groupRepository.updateGroupName(guid, newName);
  if (success) {
    final index = _viewModel.groups.indexWhere((g) => g.guid == guid);
    if (index != -1) {
      _viewModel.groups[index].name = newName;
      _viewModel.groups.refresh();
    }
  }
}

}
