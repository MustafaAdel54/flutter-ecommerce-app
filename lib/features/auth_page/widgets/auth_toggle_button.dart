import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/auth_page/cubit/auth_toggle_cubit/auth_toggle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthToggleButton extends StatelessWidget {
  const AuthToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: BlocBuilder<AuthToggleCubit, AuthToggleState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          final bool isLogin = state is AuthLoginState;
          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                alignment: isLogin
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  _buildTab(
                    context,
                    title: 'Login',
                    isActive: isLogin,
                    isLeft: true,
                  ),
                  _buildTab(
                    context,
                    title: 'Sign Up',
                    isActive: !isLogin,
                    isLeft: false,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String title,
    required bool isActive,
    required bool isLeft,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            Feedback.forTap(context);
            isLeft
                ? context.read<AuthToggleCubit>().showLogin()
                : context.read<AuthToggleCubit>().showSignUp();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isActive ? AppColors.primary : Colors.grey.shade500,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              fontSize: 15,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
