import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:e_commerce/features/cart_page/widgets/cart_item.dart';
import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        return BlocBuilder<MarketCubit, MarketState>(
          builder: (context, marketState) {
            if (cartState is CartLoaded && marketState is MarketSuccess) {
              final cartMap = cartState.items;

              final productsInCart = marketState.products.where((product) {
                return cartMap.containsKey(product.id.toString());
              }).toList();

              if (productsInCart.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Cart is empty"),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = productsInCart[index];

                  final quantity = cartMap[product.id.toString()] ?? 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CartItem(product: product, quantity: quantity),
                  );
                }, childCount: productsInCart.length),
              );
            }
            return const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
