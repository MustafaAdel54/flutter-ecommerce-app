import 'package:e_commerce/core/route/app_router.dart';
import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/features/auth_page/cubit/auth/auth_cubit.dart';
import 'package:e_commerce/features/auth_page/cubit/auth_toggle_cubit/auth_toggle_cubit.dart';
import 'package:e_commerce/features/auth_page/widgets/auth_toggle_button.dart';
import 'package:e_commerce/shared/widgets/input_field.dart';
import 'package:e_commerce/shared/widgets/primary_button.dart';
import 'package:e_commerce/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthToggleCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],

      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppRouter.main);
          }
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.surface,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthToggleCubit, AuthToggleState>(
                      builder: (context, state) {
                        bool isLogin = state is AuthLoginState;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isLogin ? 'Welcome Back' : 'Create Account',
                              style: context.textTheme.displayLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isLogin
                                  ? 'Sign in to your curated experience.'
                                  : 'Join us to explore the finest collections.',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    const AuthToggleButton(),

                    const SizedBox(height: 40),

                    BlocBuilder<AuthToggleCubit, AuthToggleState>(
                      builder: (context, state) {
                        bool isLogin = state is AuthLoginState;
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isLogin)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'UserName',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              if (!isLogin)
                                InputField(
                                  hintText: 'username',
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'username is required';
                                    }
                                    return null;
                                  },
                                ),
                              if (!isLogin) const SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Email Address',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              InputField(
                                hintText: 'name@example.com',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 33,
                                    child: Text(
                                      'PASSWORD',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  if (isLogin)
                                    TextButton(
                                      onPressed: () {
                                        context.push(AppRouter.forgotPassword);
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              InputField(
                                hintText: '••••••••',
                                controller: passwordController,
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  bool isLoading = state is AuthLoading;
                                  return PrimaryButton(
                                    text: isLogin ? 'Continue' : 'Sign Up',
                                    isLoading: isLoading,

                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (isLogin) {
                                          context.read<AuthCubit>().login(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          );
                                        } else {
                                          context.read<AuthCubit>().signUp(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                            username: usernameController.text
                                                .trim(),
                                          );
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),
                    const Center(
                      child: Text(
                        'OR CONTINUE WITH',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        SecondaryButton(
                          label: 'Google',
                          onPressed: () {},
                          icon: Icons.g_mobiledata,
                          iconColor: Colors.black,
                        ),
                        const SizedBox(width: 16),
                        SecondaryButton(
                          label: 'Apple',
                          onPressed: () {},
                          icon: Icons.apple,
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                          children: [
                            const TextSpan(
                              text: 'By continuing, you agree to our ',
                            ),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
