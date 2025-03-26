import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/gradient_text.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class VideosApprovalScreen extends StatefulWidget {
  const VideosApprovalScreen({Key? key}) : super(key: key);

  @override
  State<VideosApprovalScreen> createState() => _VideosApprovalScreenState();
}

class _VideosApprovalScreenState extends State<VideosApprovalScreen> {
  final List<Product> products = [
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video1.mp4',
      price: 120.0,
      originalPrice: 150.0,
      image: 'https://example.com/image1.jpg',
    ),
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video2.mp4',
      price: 150.0,
      originalPrice: 180.0,
      image: 'https://example.com/image2.jpg',
    ),
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video3.mp4',
      price: 150.0,
      originalPrice: 180.0,
      image: 'https://example.com/image3.jpg',
    ),
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video4.mp4',
      price: 150.0,
      originalPrice: 180.0,
      image: 'https://example.com/image4.jpg',
    ),
  ];

  void _handleApprove(int index) {
    setState(() {
      products[index].isApproved = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Video approved"),
        backgroundColor: AppColors.approveButtonColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleReject(int index) {
    setState(() {
      products[index].isApproved = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Video rejected"),
        backgroundColor: AppColors.rejectButtonColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth < 600 ? 12 : 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    _buildProductGrid(context),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              "Approve or Reject Videos",
              gradient: AppColors.appGradientColors,
              fontSize: isSmallScreen ? 22 : 28,
            ),
            const SizedBox(height: 16),
            _buildSearchBar(isSmallScreen, constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(bool isSmallScreen, double maxWidth) {
    return SizedBox(
      width: isSmallScreen ? double.infinity : maxWidth * 0.5,
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search videos...",
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Responsive grid configuration
        int crossAxisCount;
        if (screenWidth < 500) {
          crossAxisCount = 1;
        } else if (screenWidth < 800) {
          crossAxisCount = 2;
        } else if (screenWidth < 1200) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: _getAspectRatio(screenWidth),
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onApprove: () => _handleApprove(index),
              onReject: () => _handleReject(index),
            );
          },
        );
      },
    );
  }

  double _getAspectRatio(double screenWidth) {
    if (screenWidth < 500) return 1.1;
    if (screenWidth < 800) return 1.0;
    return 0.95;
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const ProductCard({
    required this.product,
    required this.onApprove,
    required this.onReject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 200;

        return Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/bowl3.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildButtonRow(isSmallScreen),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonRow(bool isSmallScreen) {
    return SizedBox(
      height: isSmallScreen ? 80 : 36,
      child: isSmallScreen
          ? Column(
              children: [
                _buildActionButton(
                  icon: Icons.check,
                  label: "Approve",
                  color: AppColors.approveButtonColor,
                  onPressed: onApprove,
                  isSmallScreen: isSmallScreen,
                ),
                const SizedBox(height: 8),
                _buildActionButton(
                  icon: Icons.close,
                  label: "Reject",
                  color: AppColors.rejectButtonColor,
                  onPressed: onReject,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.check,
                    label: "Approve",
                    color: AppColors.approveButtonColor,
                    onPressed: onApprove,
                    isSmallScreen: isSmallScreen,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.close,
                    label: "Reject",
                    color: AppColors.rejectButtonColor,
                    onPressed: onReject,
                    isSmallScreen: isSmallScreen,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required bool isSmallScreen,
  }) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSmallScreen ? 16 : 18,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
