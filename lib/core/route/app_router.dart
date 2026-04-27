import 'package:e_commerce/features/auth_page/cubit/auth/auth_cubit.dart';
import 'package:e_commerce/features/auth_page/login_screen.dart';
import 'package:e_commerce/features/cart_page/cart_screen.dart';
import 'package:e_commerce/features/forget_password_page/forget_password_screen.dart';
import 'package:e_commerce/features/main_page/main_screen.dart';
import 'package:e_commerce/features/product_details/product_details_screen.dart';
import 'package:e_commerce/features/splash_page/splash_screen.dart';
import 'package:e_commerce/shared/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const splash = '/';
  static const auth = '/auth';
  static const forgotPassword = '/forgot-password';
  static const main = '/main';
  static const cart = '/cart';
  static const productDetails = '/product-details';

  static final router = GoRouter(
    initialLocation: splash,
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggingIn = state.matchedLocation == auth;
      final isSplash = state.matchedLocation == splash;

      if (user == null && !isLoggingIn && !isSplash) {
        return auth;
      }

      if (user != null && isLoggingIn) {
        return main;
      }

      return null;
    },
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: auth, builder: (context, state) => AuthScreen()),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(path: main, builder: (context, state) => MainScreen()),
      GoRoute(path: cart, builder: (context, state) => const CartScreen()),
      GoRoute(
        path: productDetails,

        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailsScreen(product: product);
        },
      ),
    ],
  );
}
