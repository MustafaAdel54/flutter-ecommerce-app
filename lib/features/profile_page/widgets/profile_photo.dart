import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: AppColors.primary,
          child: CircleAvatar(
            radius: 66,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
        ),

        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF006A6A),
            child: Icon(Icons.edit, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}
