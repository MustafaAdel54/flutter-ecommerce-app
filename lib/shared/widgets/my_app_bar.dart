import 'package:e_commerce/core/route/app_router.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.icon});
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.surface,
      elevation: 0,
      leading: icon ?? Icon(Icons.menu, color: AppColors.primary),
      title: Text(
        'Indigo Vault',
        style: context.textTheme.titleLarge!.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.push(AppRouter.cart);
          },
          icon: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Badge(
                backgroundColor: AppColors.primary,
                smallSize: 8,
                isLabelVisible: state is CartLoaded && state.items.isNotEmpty,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.primary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
