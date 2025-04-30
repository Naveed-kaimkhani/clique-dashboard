
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/repositories/product_repo.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class ProductViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  var updatePriceLoading = false.obs;
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      error('');
      final data = await _productRepository.fetchProducts(
        page: currentPage.value,
      );

      final List<ProductModel> fetchedProducts = (data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      if (currentPage.value == 1) {
        products.assignAll(fetchedProducts);
      } else {
        products.addAll(fetchedProducts);
      }

      totalPages.value = data['pagination']['total_pages'];
    } catch (e) {
      error('Failed to load products');
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

  Future<bool> updatePrice(double percentage) async {
    updatePriceLoading.value = true;
    error.value = '';

    final success = await _productRepository.updatePricePercentage(percentage);

    updatePriceLoading.value = false;
    if (!success) {
      error.value = 'Failed to update price';
    }

    return success;
  }
}
