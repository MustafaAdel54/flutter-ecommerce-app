import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:e_commerce/features/market_page/widgets/categories.dart';
import 'package:e_commerce/features/market_page/widgets/my_search_bar.dart';
import 'package:e_commerce/features/market_page/widgets/product_grid.dart';
import 'package:e_commerce/shared/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MyAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Market',
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Curated essentials for the modern wardrobe.',
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  const MySearchBar(),
                  const SizedBox(height: 24),
                  const Categories(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          BlocBuilder<MarketCubit, MarketState>(
            builder: (context, state) {
              if (state is MarketLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is MarketSuccess) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: ProductGrid(products: state.products),
                );
              } else if (state is MarketError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text(state.message)),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox());
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
