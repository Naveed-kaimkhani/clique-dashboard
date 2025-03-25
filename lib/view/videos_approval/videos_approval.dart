import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/video_widget.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/view/products_screen/products_screen.dart';


class VideosApprovalScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
      title: "Hill's Science Diet Adult 7+, Senior Adult 7+ Premium Nutrition, Small Kibble, Dry Dog Food, Chicken, Brown Rice, & Barley, 15 lb Bag",
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
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return VideoWidget(product: products[index]);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
