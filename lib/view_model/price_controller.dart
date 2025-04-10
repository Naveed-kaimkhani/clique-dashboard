// controllers/price_controller.dart
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/repositories/product_repo.dart';

class PriceController extends GetxController {
  final _service = ProductRepository();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> updatePrice(double percentage) async {
    isLoading.value = true;
    errorMessage.value = '';

    final success = await _service.updatePricePercentage(percentage);

    isLoading.value = false;
    if (!success) {
      errorMessage.value = 'Failed to update price';
    }

    return success;
  }
}
