import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class BoxState extends StatelessWidget {
  const BoxState({
    super.key,
    required this.title,
    required this.count,
    required this.countColor,
  });
  final int count;
  final Color? countColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          color: AppColors.box,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                color: countColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(title, style: context.textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
