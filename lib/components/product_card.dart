
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/models/product.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

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
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Expanded(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: CachedNetworkImage(
      imageUrl: product.imageUrls.first, // Make sure it's a valid image URL
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  ),
),
              const SizedBox(height: 4),
              Text(
                product.productTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.cost.toStringAsFixed(2)}',
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
