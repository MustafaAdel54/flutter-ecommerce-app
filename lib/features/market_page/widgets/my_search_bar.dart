import 'package:e_commerce/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InputField(
        hintText: 'Search collection...',
        icon: Icon(Icons.search, color: Colors.grey),
      ),
    );
  }
}
