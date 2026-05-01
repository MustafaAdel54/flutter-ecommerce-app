import 'package:collection/collection.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:e_commerce/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/cart_page/widgets/order_success_dialog.dart';
import 'package:e_commerce/shared/widgets/confirmation_dialog.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        double subtotal = 0.0;

        return BlocBuilder<MarketCubit, MarketState>(
          builder: (context, marketState) {
            if (cartState is CartLoaded && marketState is MarketSuccess) {
              for (var entry in cartState.items.entries) {
                final productId = entry.key;
                final quantity = entry.value;

                final product = marketState.products.firstWhereOrNull(
                  (p) => p.id.toString() == productId,
                );

                if (product != null) {
                  subtotal += (product.price * quantity);
                }
              }
            }

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: const Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SUBTOTAL",
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        "\$${subtotal.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SHIPPING",
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        "Calculated at Next Step",
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL',
                        style: context.textTheme.displayLarge!.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: context.textTheme.displayLarge,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'Checkout',
                          icon: Icons.navigate_next,
                          onPressed: subtotal == 0
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                      title: 'Checkout Confirmation',
                                      content:
                                          'Are you sure you want to continue with your purchase?',
                                      onConfirm: () {
                                        showDialog(
                                          context: context,
                                          barrierColor: Colors.black54,
                                          barrierDismissible: false,
                                          builder: (context) =>
                                              const OrderSuccessDialog(),
                                        );
                                      },
                                    ),
                                  );
                                },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
