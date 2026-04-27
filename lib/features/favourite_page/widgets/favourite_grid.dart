import 'package:e_commerce/features/favourite_page/widgets/favourite_card.dart';
import 'package:e_commerce/shared/models/product_model.dart';
import 'package:flutter/material.dart';

class FavouriteGrid extends StatelessWidget {
  const FavouriteGrid({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return FavouriteCard(product: products[index]);
      },
    );
  }
}
