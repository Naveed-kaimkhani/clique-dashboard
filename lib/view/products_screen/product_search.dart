

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/models/product.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<dynamic> products = <dynamic>[].obs;
  RxString errorMessage = ''.obs;
  Timer? _debounce;
  final userController = Get.find<UserController>();

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts(String searchQuery) async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiEndpoints.baseUrl}/topdawg/products?search=$searchQuery'),
        headers: {
          'Authorization': 'Bearer ${userController.token.value}',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> productList = data['products'];
        products.value = productList
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();
      } else {
        errorMessage('Failed to load products.');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1200;
    final isMediumScreen = screenWidth > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Search Products'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              SizedBox(
                width: isLargeScreen
                    ? 600
                    : (isMediumScreen ? 500 : double.infinity),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: isLargeScreen ? 16.0 : 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 600), () {
                      if (value.isNotEmpty) {
                        fetchProducts(value);
                      } else {
                        products.clear();
                      }
                    });
                  },
                ),
              ),

              SizedBox(height: 24),

              // Display products in a grid
              Expanded(
                child: Obx(() {
                  if (isLoading.value) {
                    return _buildShimmerGrid(isLargeScreen);
                  } else if (products.isEmpty) {
                    return Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? 'Search for products'
                            : 'No products found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  } else {
                    return _buildProductGrid(isLargeScreen, isMediumScreen);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid(bool isLargeScreen) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ));
      },
    );
  }

  Widget _buildProductGrid(bool isLargeScreen, bool isMediumScreen) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : (isMediumScreen ? 3 : 2),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductModel product = products[index];
        return GestureDetector(
          onTap: () {
            // Get.toNamed(RouteName.productDetailsScreen, arguments: {...});
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: product.thumbnailUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(color: Colors.white),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.red),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isLargeScreen ? 16 : 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${product.cost}',
                        style: TextStyle(
                          color: AppColors.appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: isLargeScreen ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
