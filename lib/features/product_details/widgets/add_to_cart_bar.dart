import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:e_commerce/features/market_page/cubit/favourite/favourite_cubit.dart';
import 'package:e_commerce/shared/models/product_model.dart';
import 'package:e_commerce/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                List<int> favIds = [];
                if (state is FavouriteIdsLoaded) {
                  favIds = state.favoriteIds;
                }
                bool isFav = favIds.contains(product.id);
                return IconButton(
                  onPressed: () async {
                    context.read<FavouriteCubit>().toggleFavorite(product.id!);
                  },
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primary,
                    size: 28,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrimaryButton(
              text: 'Add to Cart',
              onPressed: () {
                context.read<CartBloc>().add(AddToCartEvent(product.id!));
              },
            ),
          ),
        ],
      ),
    );
  }
}
