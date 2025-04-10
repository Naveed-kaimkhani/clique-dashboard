// view_models/videos_approval_viewmodel.dart
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/model/popstream_request%20.dart';
import '../data/repositories/popstream_repository.dart';

class VideosApprovalViewModel extends GetxController {
  final PopstreamRepository _repository = PopstreamRepository();
  var requests = <PopstreamRequest>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchRequests();
    super.onInit();
  }

  Future<void> fetchRequests() async {
    try {
      isLoading(true);
      error('');
      final fetchedRequests = await _repository.fetchRequests();
      requests.assignAll(fetchedRequests);
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> approveRequest(int id) async {
    try {
      await _repository.approveRequest(id);
      final index = requests.indexWhere((request) => request.id == id);
      if (index != -1) {
        requests[index] = requests[index].copyWith(status: 'approved');
      }
      Get.snackbar('Success', 'Request approved successfully',
          snackPosition: SnackPosition.BOTTOM);
          fetchRequests();
    } catch (e) {
      Get.snackbar('Error', 'Failed to approve request',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Future<void> rejectRequest(int id) async {
  //   try {
  //     await _repository.rejectRequest(id);
  //     final index = requests.indexWhere((request) => request.id == id);
  //     if (index != -1) {
  //       requests[index] = requests[index].copyWith(status: 'rejected');
  //     }
  //     Get.snackbar('Success', 'Request rejected successfully',
  //         snackPosition: SnackPosition.BOTTOM);
  //         fetchRequests();
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to reject request',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  Future<void> rejectRequest(int id) async {
  try {
    await _repository.rejectRequest(id);
    final index = requests.indexWhere((request) => request.id == id);
    if (index != -1) {
      requests.removeAt(index); // <-- Remove the request from the list
    }
    Get.snackbar('Success', 'Request rejected successfully',
        snackPosition: SnackPosition.BOTTOM);
    fetchRequests(); // Optional: refresh list from server
  } catch (e) {
    Get.snackbar('Error', 'Failed to reject request',
        snackPosition: SnackPosition.BOTTOM);
  }
}

}