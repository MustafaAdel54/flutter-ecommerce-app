import 'package:e_commerce/core/theme/theme_cubit.dart';
import 'package:e_commerce/features/auth_page/cubit/auth/auth_cubit.dart';
import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:e_commerce/features/market_page/cubit/favourite/favourite_cubit.dart';
import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/shared/models/cart_repo.dart';
import 'package:e_commerce/shared/models/favourite_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/route/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    RepositoryProvider(
      create: (context) => CartRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => MarketCubit()..fetchProducts()),
          BlocProvider(
            create: (context) =>
                FavouriteCubit(FavouriteRepository())..loadFavourites(),
          ),
          BlocProvider(
            create: (context) => CartBloc(context.read<CartRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeCubit>().state,
      routerConfig: AppRouter.router,
    );
  }
}
