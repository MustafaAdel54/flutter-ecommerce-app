import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/route/app_router.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/market_page/cubit/favourite/favourite_cubit.dart';
import 'package:e_commerce/shared/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    memCacheHeight: 500,
                    memCacheWidth: 500,
                    imageUrl: widget.product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,

                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors
                      .transparent, // Must be transparent to see the image below
                  child: InkWell(
                    onTap: () {
                      context.push(
                        AppRouter.productDetails,
                        extra: widget.product,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    List<int> favIds = [];
                    if (state is FavouriteIdsLoaded) {
                      favIds = state.favoriteIds;
                    }

                    bool isFav = favIds.contains(widget.product.id);

                    return Material(
                      color: Colors.white.withValues(alpha: 0.8),
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          context.read<FavouriteCubit>().toggleFavorite(
                            widget.product.id!,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '\$ ${widget.product.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
