import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/gradient_text.dart';
import 'package:post_krakren_dashboard/components/product_card.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/view_model/product_view_model.dart';

class ProductPage extends StatelessWidget {
  final ProductViewModel _productViewModel = Get.put(ProductViewModel());
  // final ScrollController _scrollController = ScrollController();

  ProductPage({super.key}) {
    // _scrollController.addListener(_onScroll);
  }
  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 300) {
  //     _productViewModel.loadMoreProducts();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildHeader(context),
              const SizedBox(height: 16),

              /// Watch changes to `isLoading`, `error`, and `products`
              Obx(() {
                if (_productViewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_productViewModel.error.isNotEmpty) {
                  return Center(child: Text('Error: ${_productViewModel.error}'));
                }

                if (_productViewModel.products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
  ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _productViewModel.loadMoreProducts();
      }
    });
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GridView.builder(
                      // controller: _scrollController,

                    itemCount: _productViewModel.products.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                                  if (index == _productViewModel.products.length) {
  if (_productViewModel.currentPage.value < _productViewModel.totalPages.value) {
    return Padding(
      padding: const EdgeInsets.only(left:  28.0),
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 2,),
          GradientText( "Fetching more products. Please wait...",fontSize: 12, gradient: AppColors.appGradientColors,),
          
        ],
      ),
    );
  } else {
    return const SizedBox.shrink(); // No more products
  }
}
                      final product = _productViewModel.products[index];
                      return ProductCard(product: product);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GradientText(
                "All Products",
                gradient: AppColors.appGradientColors,
                fontSize: 22,
              ),
              
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: TextButton(
                  child: Text(
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    "Apply Price Increment",
                  ),
                  onPressed:()=> showEditPriceDialog(context), 
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search Products...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
  

void showEditPriceDialog(BuildContext context) {
  final TextEditingController controller =
      TextEditingController(text: '15');
  final FocusNode focusNode = FocusNode();

  // Animation controller would be better, but for simplicity using Tween
  final double initialScale = 0.8;
  final double targetScale = 1.0;

  Get.defaultDialog(
    title: '',
    titlePadding: EdgeInsets.zero,
    contentPadding: const EdgeInsets.all(24),
    backgroundColor: Colors.white,
    barrierDismissible: false,
    radius: 16,
    content: AnimatedScale(
      scale: targetScale,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.appGradientColors,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'Apply Price Increment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Animated text field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: focusNode.hasFocus
                          ? [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Percentage',
                        labelStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.black,
                            width: 2,
                          ),
                        ),
                        suffixText: '%',
                        suffixStyle: const TextStyle(
                          color:AppColors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Buttons row
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return _productViewModel.updatePriceLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.appColor),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    final percentage =
                                        double.tryParse(controller.text);
                                    if (percentage == null) {
                                      Get.snackbar(
                                        'Error',
                                        'Invalid percentage',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red.shade600,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    final success = await _productViewModel
                                        .updatePrice(percentage);
                                    if (success) {
                                      Get.back();
                                      Get.snackbar(
                                        'Success',
                                        'Price updated successfully',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green.shade600,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    elevation: 3,
                                    shadowColor: Colors.blue.shade200,
                                  ),
                                  child: const Text(
                                    'UPDATE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                        }),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // Auto-focus the text field
  Future.delayed(const Duration(milliseconds: 300), () {
    focusNode.requestFocus();
  });
}
}






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

// class ViewAllProductsScreen extends StatelessWidget {
//   const ViewAllProductsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//       final ProductViewModel productViewModel = Get.isRegistered<ProductViewModel>()
//     ? Get.find<ProductViewModel>()
//     : Get.put(ProductViewModel(), permanent: true);
//     return Container(
//       decoration: BoxDecoration(
//         gradient: AppColors.appGradientColors,
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           // appBar: AllProductsAppBar(title: "All Products", icon: Icons.arrow_back_ios , isNotification: true,),
//           backgroundColor: Colors.white,
//           body: Padding(
//             padding: const EdgeInsets.only(top: 12.0),
//             child: Obx(() {
//              if (productViewModel.isLoading.value && productViewModel.products.isEmpty) {
//               return CircularProgressIndicator();
//             }
            
            
//               return _buildProductGrid(context, productViewModel);
//             }),
//           ),
//         ),
//       ),
//     );
//   }


//   Widget _buildProductGrid(BuildContext context, ProductViewModel productViewModel) {
//     final size = MediaQuery.of(context).size;
//     ScrollController _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         productViewModel.loadMoreProducts();
//       }
//     });
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 300),
//       child: GridView.builder(
//         controller: _scrollController,
//         key: const ValueKey('products_grid'),
//         padding: const EdgeInsets.only(bottom:  4.0, left: 20.0, right: 20.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: size.width * 0.04,
//           childAspectRatio: 0.6,
//         ),
//         itemCount: productViewModel.products.length + 1, // +1 for the loading indicator
//         itemBuilder: (_, index) {
//           if (index == productViewModel.products.length) {
            
//             if (index == productViewModel.products.length) {
//   if (productViewModel.currentPage.value < productViewModel.totalPages.value) {
//     return Padding(
//       padding: const EdgeInsets.only(left:  28.0),
//       child: Column(
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 2,),
//           GradientText( "Fetching more products. Please wait...",fontSize: 12, gradient: AppColors.appGradientColors,),
          
//         ],
//       ),
//     );
//   } else {
//     return const SizedBox.shrink(); // No more products
//   }
// }
// }

//           final product = productViewModel.products[index];

//           return ProductCard(product: product);
//         },
//       ),
//     );
//   }

//   Widget _buildShimmerGrid(BuildContext context) {
//   final size = MediaQuery.of(context).size;

//   return GridView.builder(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       crossAxisSpacing: size.width * 0.009,
//       childAspectRatio: 0.6,
//     ),
//     itemCount: 6, // Number of shimmer items
//     itemBuilder: (context, index) => Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     ),
//   );
// }

// }