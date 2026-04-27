import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });
  final String title;
  final String description;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.displayLarge?.copyWith(fontSize: 32),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Color(0xFF735C00)),
            SizedBox(width: 2),
            Text(
              '4.9',
              style: TextStyle(
                color: Color(0xFF735C00),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Text('(128 Reviews)', style: TextStyle(fontSize: 16)),
            SizedBox(width: 25),
            Text(
              '•',
              style: TextStyle(
                color: Color(0xFFC6C5D4),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 25),
            Text(
              'In Stock',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          "\$$price",
          style: context.textTheme.displayLarge?.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[700],
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
