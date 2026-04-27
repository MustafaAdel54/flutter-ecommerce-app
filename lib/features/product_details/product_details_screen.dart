import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/product_details/widgets/add_to_cart_bar.dart';
import 'package:e_commerce/features/product_details/widgets/product_image.dart';
import 'package:e_commerce/features/product_details/widgets/product_info.dart';
import 'package:e_commerce/shared/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
        centerTitle: true,
        title: Text(
          'Product Details',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: AppColors.primary,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImage(image: product.image),
                  SizedBox(height: 24),
                  ProductInfo(
                    title: product.title,
                    description: product.description,
                    price: product.price,
                  ),
                ],
              ),
            ),
          ),
          AddToCartBar(product: product),
        ],
      ),
    );
  }
}
