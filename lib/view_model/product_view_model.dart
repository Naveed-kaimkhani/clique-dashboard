
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/repositories/product_repo.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class ProductViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;
   var updatePriceLoading = false.obs;
  var error = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
  Future<bool> updatePrice(double percentage) async {
    updatePriceLoading.value = true;
    error.value = '';

    final success = await _productRepository.updatePricePercentage(percentage);

    updatePriceLoading.value = false;
    if (!success) {
      error.value = 'Failed to update price';
    }
updatePriceLoading.value = false;
    return success;
  }
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      error('');
      final fetchedProducts = await _productRepository.fetchProducts(
        page: currentPage.value,
      );
      products.assignAll(fetchedProducts);
    } catch (e) {
      error(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void loadMoreProducts() {
    if (currentPage.value < totalPages.value && !isLoading.value) {
      currentPage.value++;
      fetchProducts();
    }
  }
}