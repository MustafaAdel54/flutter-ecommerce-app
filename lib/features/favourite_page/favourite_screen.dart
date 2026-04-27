import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/favourite_page/widgets/favourite_grid.dart';
import 'package:e_commerce/features/market_page/cubit/favourite/favourite_cubit.dart';
import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:e_commerce/shared/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(),
      body: BlocListener<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteActionMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        child: BlocBuilder<MarketCubit, MarketState>(
          builder: (context, marketState) {
            return BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, favState) {
                if (favState is FavouriteIdsLoaded &&
                    marketState is MarketSuccess) {
                  final favouriteProducts = marketState.products.where((
                    product,
                  ) {
                    return favState.favoriteIds.contains(product.id);
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'SAVED COLLECTION',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Color(0xFF006A6A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Favourite',
                          style: context.textTheme.displayLarge,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Your curated selection of artisan goods and digital treasures, kept here for later consideration.',
                          style: context.textTheme.bodySmall,
                        ),
                        Expanded(
                          child: favouriteProducts.isEmpty
                              ? const Center(
                                  child: Text("Your vault is empty!"),
                                )
                              : FavouriteGrid(products: favouriteProducts),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text("Something went wrong"));
              },
            );
          },
        ),
      ),
    );
  }
}
