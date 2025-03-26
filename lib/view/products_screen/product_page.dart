import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/gradient_text.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class ProductPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video1.mp4',
      price: 120.0,
      originalPrice: 150.0,
      image:
          'https://drive.google.com/file/d/1QBFlIIWSforFxtCiqFGqLZyMjokw6MmY/view?usp=drive_link',
    ),
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video2.mp4',
      price: 150.0,
      originalPrice: 180.0,
      image:
          'https://drive.google.com/file/d/1QBFlIIWSforFxtCiqFGqLZyMjokw6MmY/view?usp=drive_link',
    ),
    Product(
      title: 'Tuarna Alpha Cat Food Chicken & Vegetable, 1300g',
      videoUrl: 'https://example.com/video3.mp4',
      price: 150.0,
      originalPrice: 180.0,
      image:
          'https://drive.google.com/file/d/1QBFlIIWSforFxtCiqFGqLZyMjokw6MmY/view?usp=drive_link',
    ),
  ];

  ProductPage({super.key});

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
              _buildHeader(),
              const SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            0.85, // Adjusted aspect ratio to reduce height
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(product: product);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientText(
            "All Products",
            gradient: AppColors.appGradientColors,
            fontSize: 22,
          ),
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
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
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        // Handle navigation
      },
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: AspectRatio(
              //     aspectRatio: 1,
              //     child:
              //         Image.asset('assets/images/tile.jpeg', fit: BoxFit.cover),
              //   ),
              // ),
              SizedBox(
                width: double.infinity, // Fixed width
                height: 200, // Fixed height
                child:
                    Image.asset('assets/images/bowl3.jpeg', fit: BoxFit.cover),
              ),
              const SizedBox(height: 4), // Reduced spacing

              Text(
                product.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4), // Reduced spacing

              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
