import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';


class ProductGridScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: 'Scholastic Teacher Resources and Scholastic',
      rating: 5.0,
      reviewCount: 30704,
      price: 3.49,
      originalPrice: 2.80,
      deliveryDate: 'Fri, Apr 4',
      deliveryLocation: 'Pakistan',
      image: AppImages.bowl,
      ageRange: '4 - 6 years',
      deal: '3 for the price of 2',
    ),
     Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: 'Scholastic Teacher Resources and Scholastic',
      rating: 5.0,
      reviewCount: 30704,
      price: 3.49,
      originalPrice: 2.80,
      deliveryDate: 'Fri, Apr 4',
      deliveryLocation: 'Pakistan',
      image: AppImages.bowl,
      ageRange: '4 - 6 years',
      deal: '3 for the price of 2',
    ),
     Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: 'Scholastic Teacher Resources and Scholastic',
      rating: 5.0,
      reviewCount: 30704,
      price: 3.49,
      originalPrice: 2.80,
      deliveryDate: 'Fri, Apr 4',
      deliveryLocation: 'Pakistan',
      image: AppImages.bowl,
      ageRange: '4 - 6 years',
      deal: '3 for the price of 2',
    ),
     Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: 'Scholastic Teacher Resources and Scholastic',
      rating: 5.0,
      reviewCount: 30704,
      price: 3.49,
      originalPrice: 2.80,
      deliveryDate: 'Fri, Apr 4',
      deliveryLocation: 'Pakistan',
      image: AppImages.bowl,
      ageRange: '4 - 6 years',
      deal: '3 for the price of 2',
    ),
     Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: 'Scholastic Teacher Resources and Scholastic',
      rating: 5.0,
      reviewCount: 30704,
      price: 3.49,
      originalPrice: 2.80,
      deliveryDate: 'Fri, Apr 4',
      deliveryLocation: 'Pakistan',
      image: AppImages.bowl,
      ageRange: '4 - 6 years',
      deal: '3 for the price of 2',
    ),
    Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: '',
      rating: 4.0,
      reviewCount: 973,
      price: 22.00,
      originalPrice: 64.99,
      deliveryDate: 'Wed, Apr 8',
      deliveryLocation: 'Pakistan',
       image: AppImages.bowl1,
      boughtCount: '26k bought in past month',
    ),
  
      Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: '',
      rating: 4.0,
      reviewCount: 973,
      price: 22.00,
      originalPrice: 64.99,
      deliveryDate: 'Wed, Apr 8',
      deliveryLocation: 'Pakistan',
       image: AppImages.bowl1,
      boughtCount: '26k bought in past month',
    ),
  
      Product(
      title: 'Dog Cat No Tip Skid Bowls (32 oz, Black)',
      brand: '',
      rating: 4.0,
      reviewCount: 973,
      price: 22.00,
      originalPrice: 64.99,
      deliveryDate: 'Wed, Apr 8',
      deliveryLocation: 'Pakistan',
       image: AppImages.bowl1,
      boughtCount: '26k bought in past month',
    ),
  

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Check each product page for other buying options. Price and other details may vary based on product size and color.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String title;
  final String brand;
  final double rating;
  final int reviewCount;
  final double price;
  final double originalPrice;
  final String deliveryDate;
  final String deliveryLocation;
  final String image;
  final String? ageRange;
  final String? deal;
  final String? boughtCount;

  Product({
    required this.title,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.originalPrice,
    required this.deliveryDate,
    required this.deliveryLocation,
    required this.image,
    this.ageRange,
    this.deal,
    this.boughtCount,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image placeholder
            Container(
              height: 100,
              width: 200,
              color: Colors.grey[200],
              child: Center(
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Rating row
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                Text(
                  '${product.rating}',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  ' (${product.reviewCount})',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 4),
            // Product title
            Text(
              product.title.length > 50
                  ? '${product.title.substring(0, 50)}...'
                  : product.title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            // Brand
            if (product.brand.isNotEmpty)
              Text(
                product.brand,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            SizedBox(height: 4),
            // Price
            Row(
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '\$${product.originalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            // Deal or bought count
            if (product.deal != null)
              Text(
                product.deal!,
                style: TextStyle(fontSize: 10, color: Colors.green),
              ),
            if (product.boughtCount != null)
              Text(
                product.boughtCount!,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            SizedBox(height: 4),
            // Age range if available
            if (product.ageRange != null)
              Text(
                'Ages: ${product.ageRange}',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            Spacer(),
            // Delivery info
            Text(
              'Delivery ${product.deliveryDate}',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              'Ships to ${product.deliveryLocation}',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}