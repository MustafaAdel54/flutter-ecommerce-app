import 'package:e_commerce/core/route/app_router.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/theme/theme_cubit.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/auth_page/cubit/auth/auth_cubit.dart';
import 'package:e_commerce/features/profile_page/widgets/box_state.dart';
import 'package:e_commerce/features/profile_page/widgets/profile_photo.dart';
import 'package:e_commerce/features/profile_page/widgets/setting_tile.dart';
import 'package:e_commerce/shared/widgets/confirmation_dialog.dart';
import 'package:e_commerce/shared/widgets/my_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.go(AppRouter.auth);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        return Scaffold(
          appBar: MyAppBar(),
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfilePhoto(),
                      SizedBox(height: 10),
                      Text(
                        user?.displayName ?? 'User',
                        style: context.textTheme.displayLarge,
                      ),
                      SizedBox(height: 3),
                      Text(
                        user?.email ?? '',
                        style: context.textTheme.bodyLarge,
                      ),
                      SizedBox(height: 24),
                      Container(
                        height: 28,
                        width: 193,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFFFE088),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stars_rounded),
                            SizedBox(width: 6),
                            Text(
                              'VAULT ELITE MEMBER',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          BoxState(
                            title: 'ACTIVE ORDERS',
                            count: 12,
                            countColor: AppColors.primary,
                          ),
                          SizedBox(width: 20),
                          BoxState(
                            title: 'VAULT POINTS',
                            count: 24,
                            countColor: Color(0xFF735C00),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACCOUNT SETTINGS',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile(
                                  icon: Icons.assignment_outlined,
                                  label: 'My Orders',
                                  hasNavigation: true,
                                  onTap: () {},
                                ),
                                SettingsTile(
                                  icon: Icons.location_on_outlined,
                                  label: 'Shipping Address',
                                  hasNavigation: true,
                                  onTap: () {},
                                ),
                                SettingsTile(
                                  icon: Icons.dark_mode_outlined,
                                  label: 'Theme Toggle',
                                  subtitle:
                                      context.read<ThemeCubit>().state ==
                                          ThemeMode.dark
                                      ? 'Current: Dark Mode'
                                      : 'Current: Light Mode',
                                  hasSwitch: true,
                                ),
                                const SizedBox(height: 16),
                                SettingsTile(
                                  icon: Icons.logout,
                                  label: 'Logout',
                                  labelColor: Color(0xFFE57373),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ConfirmationDialog(
                                        title: 'Logout',
                                        content:
                                            'Are you sure you want to sign out?',
                                        confirmText: 'Logout',
                                        cancelText: 'Cancel',
                                        onConfirm: () {
                                          context.read<AuthCubit>().logout();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (state is AuthLoading)
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
