import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/cart_page/widgets/cart_list.dart';
import 'package:e_commerce/features/cart_page/widgets/cart_summary_section.dart';
import 'package:e_commerce/shared/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        icon: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Bag', style: context.textTheme.displayLarge),
                        const SizedBox(height: 5),
                        const Text(
                          'Review your selected pieces before checkout.',
                        ),
                      ],
                    ),
                  ),
                ),

                CartList(),
              ],
            ),
          ),
          CartSummarySection(),
        ],
      ),
    );
  }
}
